import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/data/data_source/home_api_provider.dart';
import 'package:shams/app/features/profile/view/widgets/user_information.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final updateController = Get.find<HomeApiProvider>();
    return InternalPage(
      title: 'الملف الشخصي',
      customWidget: Stack(
        alignment: Alignment.center,
        children: [
            //Data
          SingleChildScrollView(
            child: Container(
              width: Get.width,
              margin: const EdgeInsets.only(top: 240),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: USerInformationWidget(),
              ),
            ),
          ),
          //Avatar
          Positioned(
            top: 30,
            child: Column(
              children: [
                Obx(
                  () {
                    return Text(
                      updateController.homeDataList.first.user?.name ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
                const Gap(10),
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 160,
                        width: 160,
                        imageUrl:
                            updateController.homeDataList.first.user?.photoUrl ??
                                '',
                        placeholder: (context, url) => const CustomLoading(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.fill,
                          height: 160,
                          width: 160,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        
          // Edit Button
          Positioned(
            top: 190,
            right: 120,
            child: Container(
              width: 40,
              height: 40,
              padding:
                  const EdgeInsets.only(left: 9, bottom: 8, top: 5, right: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: ZoomTapAnimation(
                onTap: () {
                  Get.toNamed(Routes.editProfilePage);
                },
                child: SvgPicture.asset(
                  'assets/svgs/user-pen.svg',
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
    );
  }
}
