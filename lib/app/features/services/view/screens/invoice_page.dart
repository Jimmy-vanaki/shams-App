import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';
import 'package:shams/app/features/services/view/getX/invoice_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    InvoiceController invoiceController = Get.put(InvoiceController());
    final List shortcutList = [
      {
        "price": '5,000',
        "onTap": () {
          invoiceController.selected.value = 0;
        },
      },
      {
        "price": '10,000',
        "onTap": () {
          invoiceController.selected.value = 1;
        },
      },
      {
        "price": '15,000',
        "onTap": () {
          invoiceController.selected.value = 2;
        },
      },
    ];
    return InternalPage(
      customWidget: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: Constants.shamsBoxDecoration(context),
        child: Column(
          children: [
            const Gap(20),
            const Text(
              'للشراء من الفئة المطلوبة',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const Gap(5),
            const Text('يرجى تحديد أو اختيار المبلغ المطلوب'),
            const Gap(60),
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.length < 12) {
                  return null;
                }
                return 'رقم الجوال غير صالح';
              },
              initialValue: '09107722188',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  'رقم الهاتف',
                ),
              ),
            ),
            const Gap(30),
            AutoHeightGridView(
              itemCount: shortcutList.length,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 2),
              shrinkWrap: true,
              builder: (context, index) {
                return ZoomTapAnimation(
                  onTap: shortcutList[index]['onTap'],
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.all(10),
                      decoration:
                          Constants.shamsBoxDecoration(context).copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        border: Border(
                          right: BorderSide(
                            color: invoiceController.selected.value == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(80),
                            width: 8,
                          ),
                        ),
                      ),
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            shortcutList[index]['price'],
                            style: TextStyle(
                              fontSize: 12,
                              color: invoiceController.selected.value == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(80),
                            ),
                          ),
                          Text(
                            'IQD',
                            style: TextStyle(
                              fontSize: 12,
                              color: invoiceController.selected.value == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(80),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const Gap(30),
            Row(
              children: [
                ZoomTapAnimation(
                  onTap: () {
                    if (invoiceController.selected.value > 0) {
                      invoiceController.selected.value--;
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: Constants.shamsBoxDecoration(context),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/svgs/angle-right.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          'المبلغ بالدينار',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        const Gap(5),
                        Obx(
                          () => Center(
                            child: SizedBox(
                              height: 70,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: ListWheelScrollView.useDelegate(
                                  controller: FixedExtentScrollController(
                                    initialItem:
                                        invoiceController.selected.value,
                                  ),
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: 90,
                                  diameterRatio: 2.0,
                                  perspective: 0.003,
                                  onSelectedItemChanged: (index) {
                                    invoiceController.selected.value = index;
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      final isSelected = index ==
                                          invoiceController.selected.value;
                                      return RotatedBox(
                                        quarterTurns: 3,
                                        child: Container(
                                          width: 70,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.amberAccent
                                                : Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            shortcutList[index]['price'],
                                            style: TextStyle(
                                              fontSize: isSelected ? 24 : 20,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: isSelected
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: shortcutList.length,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                ZoomTapAnimation(
                  onTap: () {
                    if (invoiceController.selected.value <
                        shortcutList.length - 1) {
                      invoiceController.selected.value++;
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: Constants.shamsBoxDecoration(context),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/svgs/angle-left.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Text(
              'بامكانك الشراء في كل مرة من 1000 الى 100.000 دينار',
              style: TextStyle(fontSize: 10),
            ),
            const Gap(30),
            ElevatedButton(
              onPressed: () {},
              child: Text('التالي'),
            )
          ],
        ),
      ),
    );
  }
}
