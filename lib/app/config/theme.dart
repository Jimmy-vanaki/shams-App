import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/functions.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/extensions/success_color_theme.dart';

final updateController =
    Get.isRegistered<UpdateController>() ? Get.find<UpdateController>() : null;

final user = updateController?.userData.isNotEmpty == true
    ? updateController!.userData.first
    : null;

final String primaryHex = (user?.user?.agent?.primaryColor?.isNotEmpty == true)
    ? user!.user!.agent!.primaryColor!
    : "#FF967832";

final String onPrimaryHex =
    (user?.user?.agent?.onPrimaryColor?.isNotEmpty == true)
        ? user!.user!.agent!.onPrimaryColor!
        : "#FFFFFAF0";

final Color primaryColor = colorFromHex(primaryHex);
final Color onPrimaryColor = colorFromHex(onPrimaryHex);

class MyThemes {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'dijlah',
    useMaterial3: true,
    dividerTheme:
        const DividerThemeData(color: Color.fromARGB(50, 210, 210, 210)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 55, 55, 55),
        backgroundColor: const Color.fromARGB(255, 194, 194, 194),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 194, 194, 194),
      onPrimary: Color.fromARGB(255, 55, 55, 55),
      surface: Color.fromARGB(255, 55, 55, 55),
      onSurface: Color.fromARGB(255, 194, 194, 194),
      secondary: Color.fromARGB(255, 81, 0, 244),
      onSecondary: Color.fromARGB(255, 63, 34, 34),
      error: Color.fromARGB(255, 249, 52, 62),
      onError: Color(0xffffb4ab),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      SuccessColorTheme(
        successColor: Colors.lightGreen,
        onSuccessColor: Colors.white,
      ),
    ],
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'dijlah',
    useMaterial3: true,
    dividerTheme: DividerThemeData(color: primaryColor.withAlpha(50)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryColor,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      surface: onPrimaryColor,
      onSurface: primaryColor,
      secondary: const Color.fromARGB(255, 240, 205, 140),
      onSecondary: const Color(0xff22323f),
      error: const Color.fromARGB(255, 249, 52, 62),
      onError: const Color(0xffffb4ab),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      SuccessColorTheme(
        successColor: Colors.lightGreen,
        onSuccessColor: Colors.white,
      ),
    ],
  );
}
