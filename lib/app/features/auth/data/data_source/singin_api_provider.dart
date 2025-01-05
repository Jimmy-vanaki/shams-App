import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/functions.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/routes/routes.dart';

class SinginApiProvider extends GetxController {
  final rxRequestStatus = Status.completed.obs;
  final RxString errorMessage = ''.obs;
  String deviceType = '';
  String deviceId = '';
  final UpdateController updateController = Get.put(UpdateController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Dio dio = Dio(BaseOptions(
    receiveTimeout: const Duration(milliseconds: 10000),
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  Future<void> login({
    required String username,
    required String password,
  }) async {
    rxRequestStatus.value = Status.loading;
    errorMessage.value = '';
    if (Platform.isAndroid) {
      deviceType = 'Android';
    } else if (Platform.isIOS) {
      deviceType = 'iOS';
    } else {
      deviceType = 'Unknown';
    }
    try {
      deviceId = (await getId())!;
      print("device_id: $deviceId");
      print("Constants.fcmToken: ${Constants.fcmToken}");
      print("Constants.userToken: ${Constants.userToken}");

      final response = await dio.post(
        // TODO
        // "http://alshams-co.net/api/v6/login",
        "${Constants.baseUrl}/login",
        queryParameters: {
          'username': username,
          'password': password,
          'app_version': 27,
          'firebase_token': Constants.fcmToken,
          'device_type': deviceType,
          'device_token': deviceId,
        },
      );

      if (response.statusCode == 200) {
        Constants.userToken = response.data['token'];
        Constants.localStorage.write('userToken', Constants.userToken);
        Constants.isLoggedIn = true;
        updateController.resumeUpdating();
        Constants.localStorage
            .write('userInfo', {'userName': username, 'password': password});
        await updateController.updateInformation(Constants.userToken).then(
          (isSuccess) {
            if (isSuccess) {
              rxRequestStatus.value = Status.completed;
              Get.offNamed(Routes.home);
            }
          },
        );
      } else {
        errorMessage.value = response.data['errors'][0] ?? 'فشل تسجيل الدخول';
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      errorMessage.value = 'فشل تسجيل الدخول';
      print('Login Error! :$e');
      rxRequestStatus.value = Status.error;
    }
  }
}
