import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/handle_logout.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/common/widgets/exit_dialog.dart';
import 'package:shams/app/features/reporting/data/models/topup_report_model.dart';

class TopupReportApiProvider extends GetxController {
  var reportDataList = <TopupReportModel>[].obs;
  late Dio dio;

  late Rx<Status> rxRequestStatus;
  late Rx<Status> rxRequestButtonStatus;
  @override
  void onInit() {
    super.onInit();
    rxRequestStatus = Status.initial.obs;
    rxRequestButtonStatus = Status.initial.obs;
    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(milliseconds: 10000),
      validateStatus: (status) {
        return status! < 500;
      },
    ));
  }

  Future<void> fetchReportData({
    required String startDate,
    required String endDate,
  }) async {
    rxRequestStatus.value = Status.loading;
    rxRequestButtonStatus.value = Status.loading;
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
        reportDataList.clear();
        reportDataList.add(TopupReportModel.fromJson(response.data));
        rxRequestStatus.value = Status.completed;
        await Future.delayed(const Duration(seconds: 2));
        rxRequestButtonStatus.value = Status.completed;
      } else if (response.statusCode == 401) {
        handleLogout(response.data['error']['message']);
      } else {
        if ((response.data?['logged_in'] ?? 1) == 0) {
          rxRequestStatus.value = Status.completed;
          exitDialog(response.data['errors'][0]);
        } else {
          rxRequestStatus.value = Status.error;
          Get.closeAllSnackbars();
          Get.snackbar('خطأ', response.data['message']);
        }
      }
    } catch (e) {
      print(e);
      rxRequestStatus.value = Status.error;
      Get.closeAllSnackbars();
      Get.snackbar('خطأ', 'فشل في جلب البيانات.');
    }
  }
}
