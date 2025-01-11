import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/data/data_source/products_api_provider.dart';
import 'package:shams/app/features/home/data/models/home_model.dart';
import 'package:shams/app/features/home/view/getX/company_slider_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CompanyListSlider extends StatelessWidget {
  const CompanyListSlider({
    super.key,
    required this.companyList,
  });
  final List<HomeModel> companyList;
  @override
  Widget build(BuildContext context) {
    final CompanySliderController companySliderController =
        Get.put(CompanySliderController());
    final ProductsApiProvider productsApiProvider =
        Get.find<ProductsApiProvider>(tag: 'random');
    return SizedBox(
      height: 80.0,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: min(companyList.first.companies.length, 10),
        itemBuilder: (BuildContext context, int index) => ZoomTapAnimation(
          onTap: () {
            print(companyList.first.companies[index].id);
            companySliderController.currentCompany(
              index,
            );
            companySliderController.activeCompany.value =
                companyList.first.companies[index].id;
            // productsApiProvider
            //     .fetchProducts(companyList.first.companies[index].id);
          },
          child: Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: index == companySliderController.selected.value ? 120 : 80,
              height: 80,
              margin:
                  const EdgeInsets.only(left: 10, top: 2, bottom: 2, right: 2),
              clipBehavior: Clip.antiAlias,
              decoration: Constants.shamsBoxDecoration(context)
                  .copyWith(borderRadius: BorderRadius.circular(200)),
              child: Center(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: index == companySliderController.selected.value
                      ? 120
                      : 80,
                  height: 80,
                  imageUrl: companyList.first.companies[index].logoUrl,
                  placeholder: (context, url) => const CustomLoading(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/not.jpg',
                    fit: BoxFit.fill,
                    width: index == companySliderController.selected.value
                        ? 120
                        : 80,
                    height: 80,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
