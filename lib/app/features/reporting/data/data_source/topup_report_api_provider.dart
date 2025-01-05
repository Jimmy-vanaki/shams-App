import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/features/reporting/data/models/topup_report_model.dart';

class TopupReportApiProvider extends GetxController {
  var reportDataList = <TopupReportModel>[].obs;
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
    required String startDate,
    required String endDate,
  }) async {
    rxRequestStatus.value = Status.loading;
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/asiacell_transaction_list",
        queryParameters: {
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

      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.completed;
        reportDataList.clear();
        reportDataList.add(TopupReportModel.fromJson(response.data));
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
