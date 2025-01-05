import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/features/home/view/getX/purchase_methods_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PurchaseMethodsItem extends StatelessWidget {
  const PurchaseMethodsItem({
    super.key,
    required this.scale,
    required this.tag,
  });
  final double scale;
  final String tag;

  @override
  Widget build(BuildContext context) {
    PurchaseMethodsController purchaseMethodsController =
        Get.put(PurchaseMethodsController(), tag: tag);
    return Column(
      children: [
        SizedBox(
          height: scale,
          width: double.infinity,
          child: Center(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: purchaseMethodsController.purchaseMethodsList.length,
              itemBuilder: (context, index) {
                return ZoomTapAnimation(
                  onTap: () {
                    print(index);
                    if (Constants.isLoggedIn) {
                      purchaseMethodsController.selectMethod(index: index);
                    }else{
                      Get.snackbar('تنبيه', 'لاتمام عملية الشراء يرجى تسجيل الدخول');
                    }
                  },
                  child: Tooltip(
                    message: purchaseMethodsController
                        .purchaseMethodsList[index]['message'],
                    child: Obx(
                      () => Container(
                        height: scale,
                        width: scale,
                        margin: const EdgeInsets.only(
                            left: 4, top: 1, bottom: 1, right: 1),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: purchaseMethodsController
                                          .purchaseMethodsSelected.value ==
                                      index
                                  ? Colors.grey.withOpacity(0.5)
                                  : Colors.transparent,
                              blurRadius: 2,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          color: purchaseMethodsController
                                      .purchaseMethodsSelected.value ==
                                  index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset(
                          'assets/svgs/${purchaseMethodsController.purchaseMethodsList[index]['icon']}.svg',
                          colorFilter: ColorFilter.mode(
                            purchaseMethodsController
                                        .purchaseMethodsSelected.value ==
                                    index
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }
}
