import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/core/common/constants/dashed_border.dart';
import 'package:shams/app/core/routes/routes.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary, BlendMode.srcIn),
          child: Image.asset(
            'assets/images/defultLogo.png',
            fit: BoxFit.fill,
            height: 70,
            width: 80,
          ),
        ),
        DashedBorder(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: TextButton(
                onPressed: () {
                  Get.offAndToNamed(Routes.welcomePage);
                },
                child: const Text('انضم إلينا الآن .. وقم بتسجيل الدخول')),
          ),
        ),
      ],
    );
  }
}
