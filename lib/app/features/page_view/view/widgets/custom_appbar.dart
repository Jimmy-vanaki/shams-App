import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

AppBar customAppBar(
    BuildContext context, GlobalKey<SliderDrawerState> sliderDrawerKey) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).colorScheme.primary,
    leading: IconButton(
      icon: SvgPicture.asset(
        'assets/svgs/bars-staggered.svg',
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onPrimary,
          BlendMode.srcIn,
        ),
      ),
      onPressed: () {
        if (sliderDrawerKey.currentState!.isDrawerOpen) {
          sliderDrawerKey.currentState!.closeSlider();
        } else {
          sliderDrawerKey.currentState!.openSlider();
        }
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ZoomTapAnimation(
          onTap: () {
            Get.toNamed(RoutesClass.getNotifArchiveRoute());
          },
          child: SvgPicture.asset(
            'assets/svgs/bell.svg',
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    ],
  );
}
