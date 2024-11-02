import 'package:get/get.dart';

class PurchaseMethodsController extends GetxController {
  RxInt purchaseMethodsSelected = (-1).obs;

  selected({required int index}) {
    purchaseMethodsSelected.value = index;
  }
}
