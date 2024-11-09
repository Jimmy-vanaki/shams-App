import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/features/setting/view/getX/setting_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.put(SettingController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/svgs/${settingController.darkMode.value ? 'moon' : 'brightness'}.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                  width: 25,
                  height: 25,
                ),
                const Gap(10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      settingController.darkMode.value ? 'داکن' : 'فاتح',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: settingController.darkMode.value,
                    onChanged: (value) {
                      settingController.changeTheme(value);
                      Get.changeThemeMode(
                        settingController.darkMode.value
                            ? ThemeMode.dark
                            : ThemeMode.light,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const Gap(10),
          const Divider(),
          const Gap(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/svgs/print.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
                width: 25,
                height: 25,
              ),
              const Gap(10),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    'print',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          // Row(
          //   children: [
          //     const Text(
          //       'اضافة رمز الاستجابة السريع (qr code) الى فاتورة الطباعة',
          //       style: TextStyle(
          //         fontSize: 11,
          //       ),
          //     ),
          //     Obx(
          //       () => Checkbox(
          //         value: settingController.printQrcode.value,
          //         onChanged: (value) {
          //           settingController.activePrintQrCode(value!);
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          Obx(() => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'اضافة رمز الاستجابة السريع (qr code) الى فاتورة الطباعة',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
                value: settingController.printQrcode.value,
                onChanged: (newValue) {
                  settingController.activePrintQrCode(newValue!);
                },
              )),
          Obx(() => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'طباعة صورة الكارت',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
                value: settingController.printQrcode.value,
                onChanged: (newValue) {
                  settingController.activePrintQrCode(newValue!);
                },
              )),
          Obx(() => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'طباعة معلومات الكارت',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
                value: settingController.printQrcode.value,
                onChanged: (newValue) {
                  settingController.activePrintQrCode(newValue!);
                },
              )),
          const Gap(10),
          const Divider(),
          const Gap(10),
          InkWell(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/svgs/share-square.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                  width: 25,
                  height: 25,
                ),
                const Gap(10),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      'مشاركة التطبيق',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/svgs/angle-left.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                  width: 15,
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
