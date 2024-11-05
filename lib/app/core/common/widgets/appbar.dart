import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

AppBar shamsAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    elevation: 0,
    titleSpacing: 0,
    leading: IconButton(
      onPressed: () {
        print('object');
        Get.back();
      },
      icon: SvgPicture.asset(
        'assets/svgs/angle-right.svg',
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onPrimary,
          BlendMode.srcIn,
        ),
      ),
    ),
  );
}
