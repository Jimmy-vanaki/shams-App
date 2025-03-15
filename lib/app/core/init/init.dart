import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/error_widget.dart';
import 'package:shams/app/core/common/constants/get_version.dart';
import 'package:shams/app/features/home/data/data_source/home_api_provider.dart';
import 'package:shams/app/features/page_view/view/getX/scaffold_controller.dart';

Future<void> init() async {
  Get.put(ScaffoldController());
  Get.put(AppVersionController());
  // Initialize the custom error widget
  CustomErrorWidget.initialize();
  await GetStorage.init();
  Constants.userToken = Constants.localStorage.read('userToken') ?? '';
  Get.put(HomeApiProvider());
  print('Token: ${Constants.userToken}');
  // homeApiProvider.fetchHomeData();
  if (Constants.userToken.isNotEmpty) {
    Constants.isLoggedIn = true;
    // updateController.isUpdating.value = true;
  }
  await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
  ].request();
}
