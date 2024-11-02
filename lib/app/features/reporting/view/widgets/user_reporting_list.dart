import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/features/home/view/getX/purchase_methods_controller.dart';
import 'package:shams/app/features/home/view/widgets/purchase_methods_item.dart';

class USerReportingList extends StatelessWidget {
  const USerReportingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height - 320,
      child: ListView.builder(
        padding:
            const EdgeInsets.only(bottom: 90, top: 25, left: 20, right: 20),
        itemCount: 50,
        itemBuilder: (context, index) {
          PurchaseMethodsController purchaseMethodsController =
              Get.put(PurchaseMethodsController(), tag: index.toString());
          return InkWell(
            onTap: () {
              purchaseMethodsController.purchaseMethodsSelected.value = -1;
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: Constants.shamsBoxDecoration(context),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        BoardDateFormat('yyyy/MM/dd').format(DateTime.now()),
                      ),
                      Text(
                        'ASIACELL 500',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  Text('Pin Code : 984763519991'),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PurchaseMethodsItem(
                          scale: 40,
                          tag: index.toString(),
                        ),
                      ),
                      const Gap(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('text1111111'),
                          Text('text1111111111'),
                        ],
                      ),
                    ],
                  ),
                  const Gap(10),
                  Obx(
                    () {
                      return (purchaseMethodsController
                                  .purchaseMethodsSelected.value !=
                              -1)
                          ? ElevatedButton(
                              onPressed: () {}, child: Text('data'))
                          : const SizedBox();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
