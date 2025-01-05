import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/features/auth/view/widgets/signin.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: Get.width - 80,
            height: Get.height,
            child: const Signin(),
          ),
        ),
      ),
    );
  }
}
