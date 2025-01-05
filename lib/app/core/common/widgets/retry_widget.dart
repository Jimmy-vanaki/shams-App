import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
    this.onTap,
  });
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svgs/wifi-exclamation.svg',
          width: 70,
          height: 70,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        const Gap(10),
        const Text('لا يمكن الاتصال بالخادم، يرجى المحاولة مرة أخرى'),
        const Gap(50),
        if (onTap != null)
          ElevatedButton(
            onPressed: onTap,
            child: const Text('اعادة المحاولة'),
          ),
      ],
    );
  }
}
