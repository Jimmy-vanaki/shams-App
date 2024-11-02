import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shams/app/config/constants.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OtherServices extends StatelessWidget {
  const OtherServices({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> otherServicesList = [
      {
        "title": 'TopUp',
        "icon": 'point-of-sale-bill',
      },
      {
        "title": 'فاتورة',
        "icon": 'digital-payment',
      },
      {
        "title": 'باقات',
        "icon": 'box-open',
      },
    ];
    return AutoHeightGridView(
      itemCount: otherServicesList.length,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      shrinkWrap: true,
      builder: (context, index) {
        return ZoomTapAnimation(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration:Constants.shamsBoxDecoration(context).copyWith(color: Theme.of(context).colorScheme.primary),
            height: 100,
            child: Column(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    'assets/svgs/${otherServicesList[index]['icon']}.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onPrimary,
                      BlendMode.srcIn,
                    ),
                    width: 37,
                    height: 37,
                  ),
                ),
                Text(
                  otherServicesList[index]['title'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
