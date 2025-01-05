import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/routes/routes.dart';

/// Handles user logout
final updateController =
    Get.isRegistered<UpdateController>() ? Get.find<UpdateController>() : null;

void handleLogout(String message) {
  Constants.localStorage.remove('userToken');
  Get.snackbar('تنبيه', message);
  Get.offAllNamed(Routes.welcomePage);
  updateController?.isUpdating.value = false;
}
