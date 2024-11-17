import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shams/app/config/connectivity_controller.dart';
import 'package:shams/app/core/common/constants/get_version.dart';
import 'package:shams/app/features/page_view/view/getX/scaffold_controller.dart';

Future<void> init() async {
  await GetStorage.init();
  //connectivity controller
  Get.put(ConnectivityController());
  Get.put(ScaffoldController());
  Get.put(AppVersionController());
  await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
  ].request();
}
