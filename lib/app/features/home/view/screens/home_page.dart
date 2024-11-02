import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/view/getX/purchase_methods_controller.dart';
import 'package:shams/app/features/home/view/widgets/company_list_slider.dart';
import 'package:shams/app/features/home/view/widgets/other_services.dart';
import 'package:shams/app/features/home/view/widgets/purchase_methods_item.dart';
import 'package:shams/app/features/home/view/widgets/separator.dart';
import 'package:shams/app/features/home/view/widgets/wallet_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:numberpicker/numberpicker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    PurchaseMethodsController purchaseMethodsController =
        Get.put(PurchaseMethodsController());
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(10),
            WalletCard(size: size),
            const Separator(title: 'خدمات مميزة'),
            const OtherServices(),
            const Gap(20),
            CarouselSlider(
              options: CarouselOptions(
                height: 120.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(5.0),
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: Constants.shamsBoxDecoration(context),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 120,
                        width: double.infinity,
                        imageUrl:
                            "https://images.unsplash.com/ephoto-1728943492981-be3e94e4d551?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%)3D",
                        placeholder: (context, url) => const CustomLoading(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/not.jpg',
                          fit: BoxFit.fill,
                          height: 120,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Separator(title: 'الشركات', ontap: () {}),
            const CompanyListSlider(),
            Separator(title: 'مختارات', ontap: () {}),
            AutoHeightGridView(
              itemCount: 10,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 2),
              shrinkWrap: true,
              builder: (context, index) {
                return ZoomTapAnimation(
                  onTap: () {
                    print('erer');
                    showModalBottomSheet(
                      isScrollControlled: true,
                      showDragHandle: true,
                      
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          height: Get.height * .7,
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
                                    imageUrl:
                                        "https://images.unsplash.com/ephoto-1728943492981-be3e94e4d551?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%)3D",
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
                                              text: 'شركة: ',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 15,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'DIjlah IT',
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
                                              text: 'سعر: ',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 15,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '12333',
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
                                        'رقم:',
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
                                        child: NumberPicker(
                                          value: 2,
                                          minValue: 1,
                                          maxValue: 12,
                                          onChanged: (value) {},
                                          itemHeight: 30,
                                          itemWidth: 40,
                                          selectedTextStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 20),
                                          textStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(100)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Gap(20),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text('الاجراء: '),
                              ),
                              const Gap(10),
                              const PurchaseMethodsItem(
                                scale: 50,
                                tag: '0',
                              ),
                              const Gap(20),
                              ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svgs/paper-plane-top.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context).colorScheme.onPrimary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      'ارسال',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: Constants.shamsBoxDecoration(context),
                    child: Center(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 120,
                        width: double.infinity,
                        imageUrl:
                            "https://images.unsplash.com/ephoto-1728943492981-be3e94e4d551?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%)3D",
                        placeholder: (context, url) => const CustomLoading(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/not.jpg',
                          fit: BoxFit.fill,
                          height: 120,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Gap(90),
          ],
        ),
      ),
    );
  }
}
