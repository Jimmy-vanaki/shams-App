import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:dio/dio.dart';
import 'package:shams/app/features/reporting/data/models/re_print_model.dart';

class RePrintApiProvider extends GetxController {
  var rePrintDataList = <RePrintModel>[].obs;
  late Dio dio;
  final rxRequestStatus = Status.initial.obs;
  final RxBool reportPrint = false.obs;

  @override
  void onInit() {
    super.onInit();
    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 10000),
      validateStatus: (status) {
        return status! < 500;
      },
    ));
  }

  Future<bool> fetchRePrintData({
    required String cardId,
    required String serialId,
  }) async {
    rxRequestStatus.value = Status.loading;
    try {
      print(cardId);
      print(serialId);
      final response = await dio.post(
        "${Constants.baseUrl}/re_print",
        queryParameters: {
          'card_id': cardId,
          'serial_id': serialId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.completed;
        rePrintDataList.clear();
        rePrintDataList.add(RePrintModel.fromJson(response.data));

        return true;
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
        return false;
      } else {
        rxRequestStatus.value = Status.error;
        Get.closeAllSnackbars();
        Get.snackbar('خطأ', response.data['error']);
        return false;
      }
    } catch (e) {
      print(e);
      rxRequestStatus.value = Status.error;
      Get.closeAllSnackbars();
      Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      return false;
    }
  }
}
