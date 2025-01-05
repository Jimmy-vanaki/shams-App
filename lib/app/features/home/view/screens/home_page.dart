import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/common/widgets/offline_widget.dart';
import 'package:shams/app/core/common/widgets/retry_widget.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/data/data_source/home_api_provider.dart';
import 'package:shams/app/features/home/data/data_source/products_api_provider.dart';
import 'package:shams/app/features/home/view/getX/company_slider_controller.dart';
import 'package:shams/app/features/home/view/widgets/ad_slider.dart';
import 'package:shams/app/features/home/view/widgets/company_list_slider.dart';
import 'package:shams/app/features/home/view/widgets/other_services.dart';
import 'package:shams/app/features/home/view/widgets/product_list.dart';
import 'package:shams/app/features/home/view/widgets/separator.dart';
import 'package:shams/app/features/home/view/widgets/wallet_card.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final HomeApiProvider homeApiProvider = Get.find();
    final ProductsApiProvider productsApiProvider = Get.find(tag: 'random');
    final CompanySliderController companySliderController =
        Get.put(CompanySliderController());

    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () {
          switch (homeApiProvider.rxRequestStatus.value) {
            case Status.completed:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(10),
                    Constants.isLoggedIn
                        ? const WalletCard()
                        : const OfflineWidget(),
                    const Separator(title: 'خدمات مميزة'),
                    const OtherServices(),
                    const Gap(20),
                    AdSlider(homeApiProvider: homeApiProvider),
                    Separator(
                        title: 'الشركات',
                        ontap: () {
                          Get.toNamed(Routes.companiesArchivePage);
                        }),
                    CompanyListSlider(
                        companyList: homeApiProvider.homeDataList),
                    ZoomTapAnimation(
                      child: const Separator(title: 'مختارات'),
                      onTap: () {
                        productsApiProvider.fetchProducts(0);
                      },
                    ),
                    companySliderController.selected.value != -1
                        ? Obx(() {
                            if (productsApiProvider.rxRequestStatus.value ==
                                Status.loading) {
                              return const SizedBox(
                                height: 300,
                                child: Center(child: CustomLoading()),
                              );
                            } else if (productsApiProvider
                                    .rxRequestStatus.value ==
                                Status.error) {
                              return const RetryWidget();
                            } else {
                              return ProductsList(
                                products: productsApiProvider.productsDataList,
                              );
                            }
                          })
                        : ProductsList(
                            products: homeApiProvider.productsDataList,
                          ),
                    const Gap(90),
                  ],
                ),
              );
            case Status.loading:
              return const CustomLoading();
            case Status.error:
              return RetryWidget(
                onTap: () {
                  homeApiProvider.fetchHomeData();
                },
              );
            default:
              return const Text("Unknown state");
          }
        },
      ),
    );
  }
}
