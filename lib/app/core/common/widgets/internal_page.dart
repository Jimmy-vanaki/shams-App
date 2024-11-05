import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InternalPage extends StatelessWidget {
  const InternalPage({
    super.key,
    required this.customWidget,
  });
  final Widget customWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        transform: Matrix4.translationValues(0, -1, 0),
        color: Theme.of(context).colorScheme.onPrimary,
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            //Background
            Container(
              height: 150,
              width: Get.width,
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.primary,
            ),
            customWidget,
          ],
        ),
      ),
    );
  }
}
