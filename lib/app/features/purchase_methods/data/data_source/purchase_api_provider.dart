import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/features/purchase_methods/data/models/purchase_model.dart';

class PurchaseApiProvider extends GetxController {
  late Dio dio;
  final rxRequestStatus = Status.initial.obs;
  var purchaseDataList = <PurchaseModel>[].obs;
  final errorMessage = ''.obs;
  final RxBool isProcessing = false.obs;
  final UpdateController updateController = Get.find<UpdateController>();
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

  Future<bool> fetchPurchase({
    required String counter,
    required String type,
    required String cardId,
  }) async {
    errorMessage.value = '';
    rxRequestStatus.value = Status.loading;

    print(counter);
    print(type);
    print(cardId);
    print(Constants.userToken);
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/print",
        queryParameters: {
          'serial_count': counter,
          'sell_type': type,
          'card_id': cardId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        purchaseDataList.clear();
        purchaseDataList.add(PurchaseModel.fromJson(response.data));
        rxRequestStatus.value = Status.completed;
        //
        // await updateController.updateInformation();
        updateController.inventory.value = response.data['inventory'];
        updateController.update();
        print('1111printDate=======>${response.data['print_date']}');
        return true;
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
        return false;
      } else {
        errorMessage.value = response.data?['errors']?[0] ?? 'حاول مرة أخرى';
        Get.closeAllSnackbars();
        Get.snackbar('خطأ', errorMessage.value);

        rxRequestStatus.value = Status.error;
        return false;
      }
    } catch (e) {
      print(e);
      errorMessage.value = 'حاول مرة أخرى';
      rxRequestStatus.value = Status.error;
      Get.closeAllSnackbars();
      Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    rxRequestStatus.value = Status.initial;
  }
}
