import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';

class ServiceApiProvider extends GetxController {
  final RxString errorMessage = ''.obs;
  final Dio dio = Dio(BaseOptions(
    receiveTimeout: const Duration(milliseconds: 10000),
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  final rxRequestStatus = Status.initial.obs;

  Future fetchTransaction({
    required String phone,
    required String categoryId,
    required String type,
    required String price,
    required String category,
  }) async {
    rxRequestStatus.value = Status.loading;
    print(categoryId);
    print(type);
    print(phone);

    try {
      final response = await dio.post(
        "${Constants.baseUrl}/asiacell_transaction",
        queryParameters: {
          'mobile': phone,
          'category': categoryId,
          'type': type,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
      );
      print('++++++++++${response.statusCode}');
      print('++++++++++${response}');
      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.completed;
        final UpdateController updateController = Get.put(UpdateController());
        await updateController.updateInformation(Constants.userToken);
        Get.back();

        showResult(
            phone: phone,
            trackingCode: response.data['data'],
            price: price,
            category: category);
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
      } else {
        rxRequestStatus.value = Status.error;
        errorMessage.value = response.data['message'];
        Get.snackbar('خطأ', response.data['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      errorMessage.value = 'لم تتم العملية بشكل صحيح، يرجى اعادة المحاولة';
      print(e);
    }
  }
}

showResult({
  required String phone,
  required String trackingCode,
  required String price,
  required String category,
}) {
  Get.defaultDialog(
    title: ' ',
    titleStyle: const TextStyle(fontSize: 0),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svgs/terms-check.svg',
              colorFilter: const ColorFilter.mode(
                Colors.green,
                BlendMode.srcIn,
              ),
            ),
            const Gap(6),
            const Text(
              'تمت التعبئة بنجاح',
              style: TextStyle(
                color: Colors.green,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Gap(18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('رقم التتبع :'),
            const Gap(10),
            Expanded(
              child: Text(
                trackingCode,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
                textDirection: TextDirection.ltr,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        const Gap(5),
        const Divider(),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'رقم الهاتف :',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              phone,
              style: const TextStyle(
                fontSize: 17,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Gap(5),
        const Divider(),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('الفئة :'),
            Text(
              price,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Gap(5),
        const Divider(),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('السعر :'),
            Text(
              category,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    ),
  );
}
