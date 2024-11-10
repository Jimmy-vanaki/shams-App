import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool darkMode = false.obs;

  RxBool printQrcode = false.obs;
  RxBool printCardImage = false.obs;
  RxBool printInformation = false.obs;

  changeTheme(bool dark) {
    darkMode.value = dark;
  }

  activePrintQrCode(bool active) {
    printQrcode.value = active;
  }

  activePrintCardImage(bool active) {
    printCardImage.value = active;
  }

  activePrintInformation(bool active) {
    printInformation.value = active;
  }
}
