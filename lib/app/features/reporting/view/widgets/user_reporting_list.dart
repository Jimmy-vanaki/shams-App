import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/features/home/view/widgets/purchase_methods_item.dart';

class USerReportingList extends StatelessWidget {
  const USerReportingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height - 290,
      child: ListView.builder(
        padding:
            const EdgeInsets.only(bottom: 90, top: 25, left: 20, right: 20),
        itemCount: 50,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('text1111111'),
                        Text('text1111111111'),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
