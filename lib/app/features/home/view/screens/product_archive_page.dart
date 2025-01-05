import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/data/data_source/products_api_provider.dart';
import 'package:shams/app/features/home/view/widgets/product_list.dart';

class ProductArchivePage extends StatelessWidget {
  const ProductArchivePage({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  final int companyId;
  final String companyName;

  @override
  Widget build(BuildContext context) {
    final ProductsApiProvider productsApiProvider =
        Get.put(ProductsApiProvider(),tag: 'archive');

    productsApiProvider.fetchProducts(companyId);

    return InternalPage(
      customWidget: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: Constants.shamsBoxDecoration(context),
        child: Obx(() {
          if (productsApiProvider.rxRequestStatus.value == Status.loading) {
            return const Center(child: CustomLoading());
          } else if (productsApiProvider.rxRequestStatus.value ==
              Status.error) {
            return const Center(child: Text('Failed to load data.'));
          } else {
            return ProductsList(
              products: productsApiProvider.productsDataList,
            );
          }
        }),
      ),
      title: companyName,
    );
  }
}
