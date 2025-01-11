import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/routes/routes.dart';

final Dio dio = Dio(BaseOptions());
final UpdateController updateController = Get.find<UpdateController>();

Future<void> logout() async {
  try {
    final response = await dio.post(
      "${Constants.baseUrl}/logout",
      options: Options(
        headers: {
          'Authorization': 'Bearer ${Constants.userToken}',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      updateController.stopUpdating;
      Constants.localStorage.remove('userToken');
      Get.closeAllSnackbars();
      Get.snackbar('تنبيه', 'تم تسجيل الخروج بنجاح');
      Get.offAllNamed(Routes.welcomePage);
    } else if (response.statusCode == 401) {
      handleLogout(response.data['error']['message']);
    } else {
      Get.closeAllSnackbars();
      Get.snackbar('تنبيه', 'لم يتم تسجيل الخروج، يرجى اعادة المحاولة!');
    }
  } catch (e) {
    Get.closeAllSnackbars();
    Get.snackbar('تنبيه', 'لم يتم تسجيل الخروج، يرجى اعادة المحاولة!');
    print(e);
  }
}
