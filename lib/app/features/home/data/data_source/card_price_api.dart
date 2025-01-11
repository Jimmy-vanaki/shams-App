import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:dio/dio.dart';
import 'package:shams/app/features/home/data/models/card_price_model.dart';

class CardPriceApi extends GetxController {
  late Dio dio;
  final rxRequestStatus = Status.initial.obs;
  var cardPriceData = <CardPriceModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 5000),
      validateStatus: (status) {
        return status! < 500;
      },
    ));
  }

  Future fetchCardPrice({required String cardId}) async {
    print(cardId);
    rxRequestStatus.value = Status.loading;
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/card_price",
        queryParameters: {
          "card_id": cardId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
      );
      print(response.statusCode);

      print('-================${response.data['card_price']}');
      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.completed;
        cardPriceData.clear();
        cardPriceData.add(CardPriceModel.fromJson(response.data));
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
      } else {
        rxRequestStatus.value = Status.error;
        Get.closeAllSnackbars();
        Get.snackbar('خطأ', 'فشل في جلب البيانات.');
      }
    } catch (e) {
      print(e);
      rxRequestStatus.value = Status.error;
      Get.closeAllSnackbars();
      Get.snackbar('خطأ', 'فشل في جلب البيانات.');
    }
  }
}
