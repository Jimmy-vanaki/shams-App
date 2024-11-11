import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shams/app/config/connectivity_controller.dart';
import 'package:shams/app/core/common/constants/get_version.dart';
import 'package:shams/app/features/page_view/view/getX/scaffold_controller.dart';

Future<void> init() async {
  //Shared_preferences
  // final sharedPreferences = await SharedPreferences.getInstance();
  //connectivity controller
  await GetStorage.init();
  Get.put(ConnectivityController());
  Get.put(ScaffoldController());
  Get.put(AppVersionController());
}
