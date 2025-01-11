import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/functions.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/common/constants/dashed_border.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/extensions/success_color_theme.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/data/data_source/card_price_api.dart';
import 'package:shams/app/features/home/view/getX/company_slider_controller.dart';
import 'package:shams/app/features/purchase_methods/data/data_source/purchase_api_provider.dart';
import 'package:shams/app/features/home/data/models/product_model.dart';
import 'package:shams/app/features/home/view/getX/purchase_methods_controller.dart';
import 'package:shams/app/features/purchase_methods/repositories/methods_manager.dart';
import 'package:shams/app/features/purchase_methods/view/screens/purchase_methods_item.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    required this.products,
  });
  final List products;
  @override
  Widget build(BuildContext context) {
    String cardPricestr = '';
    final updateController = Get.isRegistered<UpdateController>()
        ? Get.find<UpdateController>()
        : null;
    final CompanySliderController companySliderController =
        Get.put(CompanySliderController());

    return AutoHeightGridView(
      itemCount: products.length,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      shrinkWrap: true,
      builder: (context, index) {
        CardPriceApi cardPriceApi =
            Get.put(CardPriceApi(), tag: index.toString());
        return ZoomTapAnimation(
          onTap: () {
            if (!companySliderController.isLoading.value) {
              companySliderController.isLoading.value = true;
              cardPriceApi
                  .fetchCardPrice(cardId: products[index].id.toString())
                  .then(
                (_) {
                  cardPricestr =
                      cardPriceApi.cardPriceData.first.cardPrice.toString();
                  showModalBottomSheet(
                    isScrollControlled: true,
                    showDragHandle: true,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    context: context,
                    builder: (context) {
                      PurchaseApiProvider purchaseApiProvider =
                          Get.put(PurchaseApiProvider());
                      PurchaseMethodsController purchaseMethodsController =
                          Get.put(PurchaseMethodsController(), tag: 'single');
                      cardPriceApi.cardPriceData.first.cardType == 'charge'
                          ? purchaseMethodsController.hasGlobalCard.value = true
                          : false;
                      companySliderController.isLoading.value = false;
                      return Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        height: Get.height * .87,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 160,
                                clipBehavior: Clip.antiAlias,
                                decoration:
                                    Constants.shamsBoxDecoration(context),
                                child: Center(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    height: 160,
                                    width: double.infinity,
                                    imageUrl: products[index].photoUrl,
                                    placeholder: (context, url) =>
                                        const CustomLoading(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/not.jpg',
                                      fit: BoxFit.fill,
                                      height: 160,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'الشركة: ',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 15,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  products[index].companyTitle,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(10),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'الفئة: ',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 15,
                                              ),
                                            ),
                                            TextSpan(
                                              text: products[index].title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'العدد:',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Gap(10),
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          border: Border.symmetric(
                                            vertical: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(50),
                                            ),
                                          ),
                                        ),
                                        width: 45,
                                        height: 80,
                                        child: ListWheelScrollView.useDelegate(
                                          controller: purchaseMethodsController
                                              .fixedExtentScrollController,
                                          physics:
                                              const FixedExtentScrollPhysics(),
                                          itemExtent: 35,
                                          diameterRatio: 2.0,
                                          perspective: 0.003,
                                          onSelectedItemChanged: (index) {
                                            purchaseMethodsController
                                                .counter.value = index;
                                          },
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
                                            builder: (context, index) {
                                              return Obx(
                                                () => Container(
                                                  width: 35,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: index ==
                                                            purchaseMethodsController
                                                                .counter.value
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withAlpha(70),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                      fontSize: index ==
                                                              purchaseMethodsController
                                                                  .counter.value
                                                          ? 24
                                                          : 20,
                                                      fontWeight: index ==
                                                              purchaseMethodsController
                                                                  .counter.value
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      color: index ==
                                                              purchaseMethodsController
                                                                  .counter.value
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .onPrimary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onPrimary
                                                              .withAlpha(200),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            childCount: updateController!
                                                    .userData
                                                    .first
                                                    .user
                                                    ?.agent
                                                    ?.numberCardEdition ??
                                                12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Gap(20),
                              const Align(
                                alignment: Alignment.topRight,
                                child: Text('الاجراء: '),
                              ),
                              const Gap(10),
                              const PurchaseMethodsItem(
                                scale: 50,
                                tag: 'single',
                              ),
                              Obx(() {
                                return (purchaseMethodsController
                                            .purchaseMethodsSelected.value !=
                                        -1)
                                    ? Container(
                                        margin: const EdgeInsets.all(2),
                                        child: DashedBorder(
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(30),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'الشركة: ',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      products[index]
                                                          .companyTitle,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Gap(10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'السعر: ',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${formatNumber(int.parse(cardPricestr))} IQD',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 17,
                                                      ),
                                                      textDirection:
                                                          TextDirection.ltr,
                                                    ),
                                                  ],
                                                ),
                                                const Gap(10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'الاجراء: ',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Obx(() => Text(
                                                          purchaseMethodsController
                                                                  .purchaseMethodsList[
                                                              purchaseMethodsController
                                                                  .purchaseMethodsSelected
                                                                  .value]['message'],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontSize: 17,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                const Gap(10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'العدد: ',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Obx(() => Text(
                                                          (purchaseMethodsController
                                                                      .counter
                                                                      .value +
                                                                  1)
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontSize: 17,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                if ((purchaseMethodsController
                                                                .counter.value +
                                                            1) >
                                                        1 &&
                                                    purchaseMethodsController
                                                            .purchaseMethodsSelected
                                                            .value ==
                                                        4)
                                                  Text(
                                                    'غير مسموح بإجراء التعبئة المباشرة أكثر من مرة واحدة',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                const Gap(20),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all(
                                                        Theme.of(context)
                                                            .extension<
                                                                SuccessColorTheme>()
                                                            ?.successColor,
                                                      ),
                                                    ),
                                                    onPressed:
                                                        purchaseApiProvider
                                                                .isProcessing
                                                                .value
                                                            ? null
                                                            : () {
                                                                if ((purchaseMethodsController.counter.value +
                                                                            1) >
                                                                        1 &&
                                                                    purchaseMethodsController
                                                                            .purchaseMethodsSelected
                                                                            .value ==
                                                                        4) {
                                                                } else {
                                                                  purchaseApiProvider
                                                                      .isProcessing
                                                                      .value = true;

                                                                  purchaseApiProvider
                                                                      .fetchPurchase(
                                                                    counter: (purchaseMethodsController.counter.value +
                                                                            1)
                                                                        .toString(),
                                                                    type:
                                                                        'print',
                                                                    cardId: products[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                  )
                                                                      .then(
                                                                          (isSuccessful) {
                                                                    purchaseApiProvider
                                                                        .isProcessing
                                                                        .value = false;

                                                                    if (isSuccessful) {
                                                                      Navigator.pop(
                                                                          context);

                                                                      manageMethods(
                                                                        type: purchaseMethodsController
                                                                            .purchaseMethodsSelected
                                                                            .value,
                                                                        serials: purchaseApiProvider
                                                                            .purchaseDataList
                                                                            .first
                                                                            .serials,
                                                                        cardTitle:
                                                                            purchaseApiProvider.purchaseDataList.first.cardTitle ??
                                                                                '',
                                                                        photoUrl:
                                                                            purchaseApiProvider.purchaseDataList.first.cardCategory?.photoUrl ??
                                                                                '',
                                                                        ussdCodes: purchaseApiProvider
                                                                            .purchaseDataList
                                                                            .first
                                                                            .ussdCodes,
                                                                        printDate: purchaseApiProvider
                                                                            .purchaseDataList
                                                                            .first
                                                                            .printDate
                                                                            .toString(),
                                                                        title: purchaseApiProvider.purchaseDataList.first.companyTitle ??
                                                                            '',
                                                                        footer: purchaseApiProvider.purchaseDataList.first.cardDetails2?.cardFooter?.isEmpty ??
                                                                                true
                                                                            ? (purchaseApiProvider.purchaseDataList.first.cardDetails?.cardFooter?.isEmpty ?? true
                                                                                ? ''
                                                                                : purchaseApiProvider.purchaseDataList.first.cardDetails!.cardFooter!)
                                                                            : purchaseApiProvider.purchaseDataList.first.cardDetails2!.cardFooter!,
                                                                        isReported:
                                                                            false,
                                                                      );
                                                                    }
                                                                  }).catchError(
                                                                          (error) {
                                                                    purchaseApiProvider
                                                                        .isProcessing
                                                                        .value = false;
                                                                  });
                                                                }
                                                              },
                                                    child:
                                                        purchaseApiProvider
                                                                .isProcessing
                                                                .value
                                                            ? CustomLoading(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary,
                                                              )
                                                            : Obx(
                                                                () {
                                                                  switch (purchaseApiProvider
                                                                      .rxRequestStatus
                                                                      .value) {
                                                                    case Status
                                                                          .completed:
                                                                      return CustomLoading(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onPrimary,
                                                                      );

                                                                    case Status
                                                                          .error:
                                                                      return Text(
                                                                        purchaseApiProvider
                                                                            .errorMessage
                                                                            .value,
                                                                        style:
                                                                            TextStyle(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .error,
                                                                        ),
                                                                      );
                                                                    case Status
                                                                          .loading:
                                                                      return CustomLoading(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onPrimary,
                                                                      );
                                                                    case Status
                                                                          .initial:
                                                                      return Text(
                                                                        'تأكيد',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Theme.of(context)
                                                                              .extension<SuccessColorTheme>()
                                                                              ?.onSuccessColor,
                                                                        ),
                                                                      );
                                                                    default:
                                                                      return Text(
                                                                        'تأكيد',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Theme.of(context)
                                                                              .extension<SuccessColorTheme>()
                                                                              ?.onSuccessColor,
                                                                        ),
                                                                      );
                                                                  }
                                                                },
                                                              ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              }),
                            ],
                          ),
                        ),
                      );
                    },
                  ).whenComplete(() {
                    Get.delete<PurchaseApiProvider>();
                    Get.delete<PurchaseMethodsController>(tag: 'single');
                  });
                },
              );
            }
          },
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: Constants.shamsBoxDecoration(context)
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                child: Column(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 120,
                        width: double.infinity,
                        imageUrl: products[index].photoUrl,
                        placeholder: (context, url) => const CustomLoading(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/not.jpg',
                          fit: BoxFit.fill,
                          height: 120,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        products[index].title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: cardPriceApi.rxRequestStatus.value == Status.loading
                      ? true
                      : false,
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const CustomLoading(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
