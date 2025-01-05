import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/features/home/data/models/home_model.dart';
import 'package:dio/dio.dart';
import 'package:shams/app/features/home/data/models/product_model.dart';

class HomeApiProvider extends GetxController {
  var homeDataList = <HomeModel>[].obs;
  var productsDataList = <ProductModel>[].obs;
  late Dio dio;
  final rxRequestStatus = Status.loading.obs;
  @override
  void onInit() {
    super.onInit();
    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 10000),
    ));
    if (Constants.userToken.isNotEmpty) {
      Constants.isLoggedIn = true;
    }
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    rxRequestStatus.value = Status.loading;
    try {
      final response = await dio.get(
        "${Constants.baseUrl}/home",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.completed;
        homeDataList.clear();
        homeDataList.add(HomeModel.fromJson(response.data));
        productsDataList.clear();
        if (response.data['card_categories'] != null &&
            response.data['card_categories'] is List) {
          productsDataList.addAll(
            (response.data['card_categories'] as List)
                .map((item) => ProductModel.fromJson(item))
                .toList(),
          );
        }
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
      } else {
        rxRequestStatus.value = Status.error;
        Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      }
    } catch (e) {
      print(e);
      rxRequestStatus.value = Status.error;
      Get.snackbar('خطأ', 'فشل في جلب البيانات.');
    }
  }
}
