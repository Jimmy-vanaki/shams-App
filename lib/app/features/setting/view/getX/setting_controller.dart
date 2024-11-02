import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool darkMode = false.obs;
  RxBool printQrcode = false.obs;
  changeTheme(bool dark) {
    darkMode.value = dark;
  }

  activePrintQrCode(bool active) {
    printQrcode.value = active;
  }
}
