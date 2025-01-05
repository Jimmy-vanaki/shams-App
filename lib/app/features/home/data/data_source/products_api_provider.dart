import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:dio/dio.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/features/home/data/models/product_model.dart';

class ProductsApiProvider extends GetxController {
  var productsDataList = <ProductModel>[].obs;
  late Dio dio;
  final rxRequestStatus = Status.initial.obs;

  @override
  void onInit() {
    super.onInit();
    dio = Dio();
  }

  Future<void> fetchProducts(int companyId) async {
    print(companyId);
    print(Constants.userToken);
    rxRequestStatus.value = Status.loading;
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/company_categories",
        queryParameters: {
          "company_id": companyId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      print(response.statusCode);
      print(response);

      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.completed;

        productsDataList.clear();
        productsDataList.addAll(
          (response.data['card_categories'] as List)
              .map((item) => ProductModel.fromJson(item))
              .toList(),
        );
        print(response.statusCode);
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
      } else {
        rxRequestStatus.value = Status.error;
        Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      }
    } catch (e) {
      print(e);
      rxRequestStatus.value = Status.error;
    }
  }
}
