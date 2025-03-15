import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/data/data_source/home_api_provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Constants.isLoggedIn
                ? Obx(
                    () {
                      final updateController = Get.find<HomeApiProvider>();
                      if (updateController.homeDataList.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      final user = updateController.homeDataList.first;
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          // Adjust the image height to a maximum and allow width to adapt dynamically
                          return CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 70, // Use maximum height of the parent
                            width: null, // Auto width; will adjust dynamically
                            imageUrl: user.user?.agent?.appPhotoUrl ?? '',
                            placeholder: (context, url) =>
                                const CustomLoading(),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/defultLogo.png',
                              fit: BoxFit.fill,
                              height: 70, // Maximum height for the error image
                              width: null, // Auto width for error image
                            ),
                          );
                        },
                      );
                    },
                  )
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                    child: Image.asset(
                      'assets/images/defultLogo.png',
                      fit: BoxFit.fill,
                      height: 70,
                      width: 80,
                    ),
                  ),
            const Gap(20),
            Obx(
              () {
                final updateController = Get.find<HomeApiProvider>();
                if (updateController.homeDataList.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Text(
                  (updateController.homeDataList.first.user?.agent
                                  ?.description !=
                              null &&
                          updateController.homeDataList.first.user!.agent!
                              .description!.isNotEmpty)
                      ? updateController
                          .homeDataList.first.user!.agent!.description!
                      : '''
شركة الشمس
شركة متخصصة في مجال أنظمة بيع وتوزيع البطاقات الرقمية والخدمات الالكترونية، تتميز بطاقم اداري متخصص وذو خبرة واسعة في هذا المجال لتصبح بذلك واحدة من أفضل الشركات في المنطقة.

تطبيق الشمس
نظام متكامل لبيع وتسويق البطاقات الالكترونية المحلية والعالمية متخصصة في مجال بطاقات تعبئة الأرصدة لمختلف الشركات المحلية و العالمية وأجهزة POS بمختلف أنواعها.
                          ''',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    height: 2.5,
                  ),
                );
              },
            ),
            const Gap(60),
          ],
        ),
      ),
    );
  }
}
