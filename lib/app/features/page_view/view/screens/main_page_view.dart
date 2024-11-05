import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/core/common/widgets/bottom_navigation_bar.dart';
import 'package:shams/app/features/about_us/view/screens/about_page.dart';
import 'package:shams/app/features/home/view/screens/home_page.dart';
import 'package:shams/app/features/page_view/view/getX/navigation_controller.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:shams/app/features/page_view/view/getX/scaffold_controller.dart';
import 'package:shams/app/features/page_view/view/widgets/custom_appbar.dart';
import 'package:shams/app/core/common/widgets/custom_drawer.dart';
import 'package:shams/app/features/notif/view/screens/notification_archive.dart';
import 'package:shams/app/features/reporting/view/screens/reporting_page.dart';
import 'package:shams/app/features/setting/view/screens/setting_page.dart';

class MainPageView extends GetView<ScaffoldController> {
  const MainPageView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    //navigation controller
    final BottmNavigationController navigationController =
        Get.put(BottmNavigationController(), permanent: true);

    return Scaffold(
      body: SliderDrawer(
        key: controller.sliderDrawerKey,
        isDraggable: true,
        sliderBoxShadow: SliderBoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(100)),
        appBar: customAppBar(context, controller.sliderDrawerKey),
        slideDirection: SlideDirection.RIGHT_TO_LEFT,
        sliderOpenSize: 260,
        slider: CustomDrawer(
          sliderDrawerKey: controller.sliderDrawerKey,
        ),
        child: Container(
          width: Get.width,
          height: Get.height,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: navigationController.pageController,
                onPageChanged: navigationController.animatedToPage,
                // physics: const BouncingScrollPhysics(),
                children: const [
                  HomePage(),
                  AboutPage(),
                  SettingPage(),
                  ReportingPage(),
                ],
              ),
              Positioned(
                bottom: 10,
                child: CostumBottomNavigationBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
