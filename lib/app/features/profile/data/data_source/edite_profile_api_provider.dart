import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';

class EditeProfileApiProvider extends GetxController {
  final rxRequestStatus = Status.initial.obs;
  final errorMessage = ''.obs;

  final Dio dio = Dio(BaseOptions(
    receiveTimeout: const Duration(milliseconds: 10000),
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  Future<void> updateProfile({
    required String address,
    required String mobile,
    required String password,
    required String passwordConfirmation,
    required String? photo,
    required String? lat,
    required String? lon,
  }) async {
    rxRequestStatus.value = Status.loading;
    errorMessage.value = '';
    try {
      print('Lat: $lat, Long: $lon');
      final response = await dio.post(
        "${Constants.baseUrl}/update_profile",
        queryParameters: {
          'address': address,
          'mobile': mobile,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'lat': lat,
          'lon': lon,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'photo': photo,
        },
      );
      print('Update Profile${response.statusCode}');
      print('Update Profile${response.data}');

      if (response.statusCode == 200) {
        Constants.localStorage.remove('userInfo');
        Get.snackbar('تنبيه', 'تم حفظ المعلومات');
        rxRequestStatus.value = Status.completed;
        final UpdateController updateController = Get.find<UpdateController>();
        await updateController.updateInformation(Constants.userToken);
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
      } else {
        errorMessage.value = 'لم يتم حفظ المعلومات بشكل صحيح';
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      errorMessage.value = 'لم يتم حفظ المعلومات بشكل صحيح';
      print('Login Error! :$e');
      rxRequestStatus.value = Status.error;
    }
  }
}
