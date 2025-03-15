import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/functions.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/features/home/data/models/home_model.dart';
import 'package:dio/dio.dart';
import 'package:shams/app/features/home/data/models/product_model.dart';

class HomeApiProvider extends GetxController {
  var homeDataList = <HomeModel>[].obs;
  var productsDataList = <ProductModel>[].obs;
  RxInt inventory = 000.obs;
  late Dio dio;
  final rxRequestStatus = Status.loading.obs;

  @override
  void onInit() {
    super.onInit();
    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 20000),
    ));
    if (Constants.userToken.isNotEmpty) {
      Constants.isLoggedIn = true;
    }
    // fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    print("userToken =======?>>: ${Constants.userToken.toString()}");
    rxRequestStatus.value = Status.loading;
    try {
      final response = await dio.get(
        "${Constants.baseUrl}/home",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("response.statusCode =======?>>: ${response.statusCode}");

      if (response.statusCode == 200) {
        if ((response.data?['user']?['logged_in'] ?? 0) == 1) {
          rxRequestStatus.value = Status.completed;

          await _handleThemeChange(response);

          homeDataList.clear();
          homeDataList.add(HomeModel.fromJson(response.data));
          productsDataList.clear();
          inventory.value = response.data?['user']?['total_balance'] ?? 000;

          if (response.data['card_categories'] != null &&
              response.data['card_categories'] is List) {
            productsDataList.addAll(
              (response.data['card_categories'] as List)
                  .map((item) => ProductModel.fromJson(item))
                  .toList(),
            );
          }
        } else {
          handleLogout('تم تسجيل خروجك من قبل المشرف!');
        }
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
      } else {
        rxRequestStatus.value = Status.error;
        Get.closeAllSnackbars();
        Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      }
    } catch (e) {
      print(e);
      rxRequestStatus.value = Status.error;
      Get.closeAllSnackbars();
      Get.snackbar('خطأ', 'فشل في جلب البيانات.');
    }
  }

  /// Handles theme color changes
  Future<void> _handleThemeChange(response) async {
    // Helper function to validate and return a proper hex color
    String getValidColor(String? color, String defaultColor) {
      if (color != null && color.isNotEmpty && color.startsWith('#')) {
        return color;
      }
      return defaultColor;
    }

    // Default colors
    const String defaultPrimaryColor = "#FF967832";
    const String defaultOnPrimaryColor = "#FFFFFAF0";

    // Get current user data colors or use defaults
    final primaryColor = (homeDataList.isNotEmpty)
        ? getValidColor(
            homeDataList.first.user?.agent?.primaryColor, defaultPrimaryColor)
        : defaultPrimaryColor;

    final onPrimaryColor = (homeDataList.isNotEmpty)
        ? getValidColor(homeDataList.first.user?.agent?.onPrimaryColor,
            defaultOnPrimaryColor)
        : defaultOnPrimaryColor;

    // Convert current colors to Color objects
    final Color oldPrimaryColor = colorFromHex(primaryColor);
    final Color oldOnPrimaryColor = colorFromHex(onPrimaryColor);

    // Extract new colors from response and validate
    final responseData = response.data['user']?['agent'];

    final Color newPrimary = colorFromHex(
      getValidColor(responseData?['primary_color'], defaultPrimaryColor),
    );

    final Color newOnPrimaryColor = colorFromHex(
      getValidColor(responseData?['on_primary_color'], defaultOnPrimaryColor),
    );

    print("oldPrimaryColor =======?>>: ${primaryColor}");
    print(
        "newPrimary =======?>>: ${getValidColor(responseData?['primary_color'], defaultPrimaryColor)}");
    // If colors have changed, update the theme
    if (oldPrimaryColor != newPrimary ||
        oldOnPrimaryColor != newOnPrimaryColor) {
      Get.changeTheme(
        ThemeData(
          brightness: Brightness.light,
          fontFamily: 'dijlah',
          useMaterial3: true,
          dividerTheme: DividerThemeData(
            color: newPrimary.withAlpha(50),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: newOnPrimaryColor,
              backgroundColor: newPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: newPrimary,
            onPrimary: newOnPrimaryColor,
            surface: newOnPrimaryColor,
            onSurface: newPrimary,
            secondary: const Color.fromARGB(255, 240, 205, 140),
            onSecondary: const Color(0xff22323f),
            error: const Color.fromARGB(255, 249, 52, 62),
            onError: const Color(0xffffb4ab),
            tertiary: const Color.fromARGB(255, 200, 200, 200),
          ),
        ),
      );
    }
  }
}
