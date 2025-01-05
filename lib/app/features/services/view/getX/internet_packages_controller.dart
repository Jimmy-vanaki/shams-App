import 'package:get/get.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/data/models/update_info_model.dart';

class InternetPackagesController extends GetxController {
  final updateController = Get.find<UpdateController>();

  final RxList<dynamic> companyList = RxList<dynamic>();
  final RxList<dynamic> packageList = [].obs;

  RxInt companySelected = 0.obs;
  @override
  void onInit() {
    super.onInit();
    companyList.assignAll(
      updateController.userData.first.asiacellCategories
          !.where((category) =>
              category.type == Type.BUNDLE && category.parentId == null)
          .map((category) => category.toJson())
          .toList(),
    );
    buildPackageList(3);
  }

  listOfPackage(int companyId) {
    buildPackageList(companyId);
  }

  buildPackageList(int index) {
    packageList.assignAll(
      updateController.userData.first.asiacellCategories
          !.where((category) =>
              category.type == Type.BUNDLE && category.parentId == index)
          .map((category) => category.toJson())
          .toList(),
    );
  }
}
