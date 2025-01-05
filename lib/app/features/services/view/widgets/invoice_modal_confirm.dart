import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/extensions/success_color_theme.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/services/data/data_source/service_api_provider.dart';

Future<dynamic> invoiceModalConfirm({
  required BuildContext context,
  required String phone,
  required String price,
  required String category,
  required String categoryId,
  required String type,
}) {
  ServiceApiProvider serviceApiProvider = Get.put(ServiceApiProvider());

  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        alignment: Alignment.topCenter,
        height: Get.height * .3,
        child: Column(
          children: [
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
                      fontSize: 16,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const Gap(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('الفئة :'),
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const Gap(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('السعر :'),
                Text(
                  category,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Theme.of(context)
                      .extension<SuccessColorTheme>()
                      ?.successColor),
                ),
                onPressed: () {
                  serviceApiProvider.fetchTransaction(
                    phone: phone,
                    categoryId: categoryId,
                    type: type,
                    price: price,
                    category: category,
                  );
                },
                child: Obx(() {
                  final requestStatus =
                      serviceApiProvider.rxRequestStatus.value;

                  switch (requestStatus) {
                    case Status.loading:
                      return const Center(child: CustomLoading());

                    case Status.error:
                      return Text(
                        'لم تتم العملية بشكل صحيح، يرجى اعادة المحاولة',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      );

                    case Status.initial:
                      return Text(
                        'تأكيد',
                        style: TextStyle(
                          color: Theme.of(context)
                              .extension<SuccessColorTheme>()
                              ?.onSuccessColor,
                        ),
                      );

                    case Status.completed:
                    default:
                      return Text(
                        'تأكيد',
                        style: TextStyle(
                          color: Theme.of(context)
                              .extension<SuccessColorTheme>()
                              ?.onSuccessColor,
                        ),
                      );
                  }
                }),
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(
    () {
      FocusScope.of(context).unfocus();
      Get.delete<ServiceApiProvider>();
    },
  );
}
