import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:shams/app/features/page_view/view/getX/navigation_controller.dart';
import 'package:shams/app/features/text_content/view/screen/text_content.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.sliderDrawerKey,
  });
  final GlobalKey<SliderDrawerState> sliderDrawerKey;

  @override
  Widget build(BuildContext context) {
    final BottmNavigationController navigationController =
        Get.put(BottmNavigationController(), permanent: true);
    final List<Map<String, dynamic>> drawerItemList = [
      {
        "title": 'الرئيسية',
        "icon": 'house',
        "onTap": () {
          sliderDrawerKey.currentState?.closeSlider();
          navigationController.goToPage(0);
        },
      },
      {
        "title": 'الملف الشخصي',
        "icon": 'user',
        "onTap": () {},
      },
      {
        "title": 'الاشعارات',
        "icon": 'bell',
        "onTap": () {
          Get.toNamed(
            RoutesClass.getNotifArchiveRoute(),
          );
        },
      },
      {
        "title": 'حول التطبيق',
        "icon": 'info',
        "onTap": () {
          sliderDrawerKey.currentState?.closeSlider();
          navigationController.goToPage(1);
        },
      },
      {
        "title": 'سياسية الخصوصية',
        "icon": 'confidential-discussion',
        "onTap": () {
          Get.toNamed(RoutesClass.getTextContent(),
              arguments:
                  const TextContent(title: 'سياسية الخصوصية', text: 'text'));
        },
      },
      {
        "title": 'الدعم الفني',
        "icon": 'user-headset',
        "onTap": () {
          Get.toNamed(RoutesClass.getTextContent(),
              arguments: const TextContent(title: 'الدعم الفني', text: 'text'));
        },
      },
      {
        "title": 'الشروط والقوانين',
        "icon": 'terms-info',
        "onTap": () {
          // sliderDrawerKey.currentState?.closeSlider();
          Get.toNamed(RoutesClass.getTextContent(),
              arguments:
                  const TextContent(title: 'الشروط والقوانين', text: 'text'));
        },
      },
      {
        "title": 'إعدادات',
        "icon": 'settings',
        "onTap": () {
          sliderDrawerKey.currentState?.closeSlider();
          navigationController.goToPage(2);
        },
      },
      {
        "title": 'خروج',
        "icon": 'sign-out-alt',
        "onTap": () {
          Get.dialog(
            AlertDialog(
              title: const Text('تنبيه'),
              content: const Text('هل تريد تسجيل الخروج من حسابك؟'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'لا',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'نعم',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      },
    ];
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Mohammad',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            accountEmail: Text(
              'm.vanaki77@gmail.com',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            currentAccountPicture: ClipOval(
              child: Image.asset('assets/images/profile.png'),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: drawerItemList.length,
            itemBuilder: (context, index) {
              return index != 7
                  ? drawerItemWidget(
                      title: drawerItemList[index]['title'],
                      icon: drawerItemList[index]['icon'],
                      onTap: drawerItemList[index]['onTap'],
                      tag: index,
                      context: context,
                    )
                  : Column(
                      children: [
                        const Divider(),
                        drawerItemWidget(
                          title: drawerItemList[index]['title'],
                          icon: drawerItemList[index]['icon'],
                          onTap: drawerItemList[index]['onTap'],
                          tag: index,
                          context: context,
                        )
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  ListTile drawerItemWidget({
    required String title,
    required String icon,
    required int tag,
    required Function() onTap,
    required BuildContext context,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        'assets/svgs/$icon.svg',
        colorFilter: ColorFilter.mode(
          tag != 8 ? Theme.of(context).colorScheme.primary : Colors.red,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: tag != 8 ? Theme.of(context).colorScheme.primary : Colors.red,
        ),
      ),
      trailing: tag != 8
          ? SvgPicture.asset(
              'assets/svgs/angle-left.svg',
              width: 12,
              height: 12,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            )
          : const SizedBox(),
      onTap: onTap,
    );
  }
}
