import 'dart:io';

import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:dio/dio.dart';
import 'package:shams/app/features/notif/data/models/notif_model.dart';

class NotifApiProvider extends GetxController {
  var notifDataList = <NotificationsModel>[].obs;
  late Dio dio;
  String deviceType = '';
  final rxRequestStatus = Status.loading.obs;
  @override
  void onInit() {
    super.onInit();
    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 10000),
    ));
    fetchNotifData();
  }

  Future<void> fetchNotifData() async {
    rxRequestStatus.value = Status.loading;
    if (Platform.isAndroid) {
      deviceType = 'android';
    } else if (Platform.isIOS) {
      deviceType = 'iOS';
    } else {
      deviceType = 'Unknown';
    }
    print('deviceType ---->$deviceType');
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/notifications",
        queryParameters: {
          'device_type': deviceType,
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
        notifDataList.clear();
        notifDataList.add(NotificationsModel.fromJson(response.data));
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
      } else {
        rxRequestStatus.value = Status.error;
        Get.closeAllSnackbars();
        Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      }
    } catch (e) {
      print(e);
      rxRequestStatus.value = Status.error;
      Get.closeAllSnackbars();
      Get.snackbar('خطأ', 'فشل في جلب البيانات.');
    }
  }
}
