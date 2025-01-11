import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/functions.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/purchase_methods/data/data_source/purchase_api_provider.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UpdateController updateController = Get.find<UpdateController>();
    // final PurchaseApiProvider purchaseApiProvider =
    //     Get.find<PurchaseApiProvider>();

    return Obx(
      () {
        if (updateController.userData.isEmpty) {
          return const Center(
            child: CustomLoading(),
          );
        }
        final user = updateController.userData.first;

        return Container(
          height: 200,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: Constants.shamsBoxDecoration(context).copyWith(
            image: DecorationImage(
              image: const AssetImage(
                'assets/images/bg-v-card.png',
              ),
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary, BlendMode.color),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main widget
              LayoutBuilder(
                builder: (context, constraints) {
                  // Adjust the image height to a maximum and allow width to adapt dynamically
                  return CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 70, // Use maximum height of the parent
                    width: null, // Auto width; will adjust dynamically
                    imageUrl: user.user?.agent?.appPhotoUrl ?? '',
                    placeholder: (context, url) => const CustomLoading(),
                    errorWidget: (context, url, error) => ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/images/defultLogo.png',
                        fit: BoxFit.fill,
                        height: 70, // Maximum height for the error image
                        width: null, // Auto width for error image
                      ),
                    ),
                  );
                },
              ),

              Text(
                user.user?.name ?? '',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 17,
                ),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '      رصيدك',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Obx(() => Text(
                        formatNumber(updateController.inventory.value) ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Expanded(
                    child: Text(
                      '    IQD',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
