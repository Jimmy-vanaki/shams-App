import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  FixedExtentScrollController fixedExtentScrollController =
      FixedExtentScrollController();
  RxInt selected = 0.obs;

  @override
  void onInit() {
    fixedExtentScrollController =
        FixedExtentScrollController(initialItem: selected.value);
    super.onInit();
  }

  @override
  void onClose() {
    fixedExtentScrollController.dispose();
    super.onClose();
  }

  goToItem(int index) {
    selected.value = index;
    fixedExtentScrollController.jumpToItem(
      index,
    );
  }
}
