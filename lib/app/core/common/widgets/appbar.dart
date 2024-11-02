import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

AppBar shamsAppbar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        print('object');
        Get.back();
      },
      icon: SvgPicture.asset(
        'assets/svgs/house.svg',
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
    ),
  );
}
