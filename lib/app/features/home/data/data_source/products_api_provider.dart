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
  CancelToken? cancelToken;

  @override
  void onInit() {
    super.onInit();
    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 20000),
      validateStatus: (status) {
        return status! < 500;
      },
    ));
  }

  Future<void> fetchProducts(int companyId) async {
    print(companyId);
    print(Constants.userToken);

    // Cancel any ongoing request if it exists
    if (cancelToken != null) {
      cancelToken?.cancel("Request cancelled due to new request.");
    }

    // Create a new CancelToken for the new request
    cancelToken = CancelToken();

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
        cancelToken: cancelToken,
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
        rxRequestStatus.value = Status.error;
        handleLogout(response.data['error']['message']);
      } else {
        rxRequestStatus.value = Status.error;
        if (Get.isSnackbarOpen == false) {
          Get.closeAllSnackbars();
          Get.snackbar(
            'خطأ',
            'فشل في جلب البيانات.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
        Get.closeAllSnackbars();
        Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      }
    } catch (e) {
      print("Request was cancelled");
    }
  }
}
