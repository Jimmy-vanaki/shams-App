import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/error_widget.dart';
import 'package:shams/app/core/common/constants/get_version.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/features/page_view/view/getX/scaffold_controller.dart';

Future<void> init() async {
  Get.put(ScaffoldController());
  Get.put(AppVersionController());
  // Initialize the custom error widget
  CustomErrorWidget.initialize();
  await GetStorage.init();

  Constants.userToken = Constants.localStorage.read('userToken') ?? '';
  print('Token: ${Constants.userToken}');

  final UpdateController updateController = Get.put(UpdateController());
  if (Constants.userToken.isNotEmpty) {
    Constants.isLoggedIn = true;
    // updateController.isUpdating.value = true;
    await updateController.updateInformation();
  }
  await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
  ].request();
}
