import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:shams/app/core/utils/custom_loading.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(RoutesClass.intro);
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              width: size.width,
              height: size.height,
              'assets/images/splash-bg.jpg',
              fit: BoxFit.fill,
            ),
            Image.asset(
              'assets/images/splash-cn.png',
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 40,
              child: Column(
                children: [
                  const CustomLoading(),
                  const Gap(15),
                  Text(
                    'يرجى الانتظار...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}