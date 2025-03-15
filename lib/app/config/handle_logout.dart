import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:shams/app/features/home/data/data_source/home_api_provider.dart';

/// Handles user logout
final updateController =
    Get.isRegistered<HomeApiProvider>() ? Get.find<HomeApiProvider>() : null;

void handleLogout(String message) {
  Constants.localStorage.remove('userToken');
  Get.closeAllSnackbars();
  Get.snackbar('تنبيه', message);
  Get.offAllNamed(Routes.welcomePage);
}
