import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:dio/dio.dart';
import 'package:shams/app/features/reporting/data/models/report_model.dart';

class ReportListApiProvider extends GetxController {
  var reportDataList = <ReportModel>[].obs;
  late Dio dio;
  final rxRequestStatus = Status.initial.obs;
  @override
  void onInit() {
    super.onInit();
    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 10000),
    ));
  }

  Future<void> fetchReportData({
    required String productId,
    required String companyId,
    required String startDate,
    required String endDate,
  }) async {
    rxRequestStatus.value = Status.loading;
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/sell_serials",
        queryParameters: {
          'card_category_id': productId,
          'company_id': companyId,
          'start_date': startDate,
          'end_date': endDate,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            'Content-Type': 'application/json',
          },
        ),
      );
      print(productId);
      print(companyId);
      print(startDate);
      print(endDate);
      print(response.statusCode);

      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.completed;
        reportDataList.clear();
        reportDataList.add(ReportModel.fromJson(response.data));
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
