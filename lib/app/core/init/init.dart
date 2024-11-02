import 'package:get/get.dart';
import 'package:shams/app/config/connectivity_controller.dart';
import 'package:shams/app/features/page_view/view/getX/scaffold_controller.dart';

Future<void> init() async {
  //Shared_preferences
  // final sharedPreferences = await SharedPreferences.getInstance();
  //connectivity controller
  Get.put(ConnectivityController());
  Get.put(ScaffoldController());
}
