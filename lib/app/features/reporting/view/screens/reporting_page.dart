import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/common/widgets/offline_widget.dart';
import 'package:shams/app/core/common/widgets/retry_widget.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/data/data_source/products_api_provider.dart';
import 'package:shams/app/features/home/view/getX/company_archive_controller.dart';
import 'package:shams/app/features/reporting/data/data_source/re_print_api_provider.dart';
import 'package:shams/app/features/reporting/data/data_source/report_list_api_provider.dart';
import 'package:shams/app/features/reporting/view/getX/report_value_controller.dart';
import 'package:shams/app/features/reporting/view/widgets/category_dropdown.dart';
import 'package:shams/app/features/reporting/view/widgets/date.dart';
import 'package:shams/app/features/reporting/view/widgets/user_reporting_list.dart';

class ReportingPage extends StatelessWidget {
  const ReportingPage({super.key});
  @override
  Widget build(BuildContext context) {
    ReportListApiProvider reportListApiProvider =
        Get.put(ReportListApiProvider());
    RePrintApiProvider rePrintApiProvider = Get.put(RePrintApiProvider());
    ReportValueController reportValueController =
        Get.put(ReportValueController());
    final CompanyArchiveController companyArchiveController =
        Get.put(CompanyArchiveController());
    final ProductsApiProvider productsApiProvider =
        Get.put(ProductsApiProvider(), tag: 'archive');
    return Container(
      transform: Matrix4.translationValues(0, -1, 0),
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(10),
            Container(
              alignment: Alignment.center,
              height: 220,
              width: Get.width - 40,
              padding: const EdgeInsets.all(20),
              decoration: Constants.shamsBoxDecoration(context),
              child: Constants.isLoggedIn
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ReportingDate(),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CategoryDropdown(
                              itemList: [
                                const DropdownMenuEntry(
                                    value: 'الکل', label: 'الکل'),
                                ...companyArchiveController.filteredCompanies
                                    .map((company) {
                                  return DropdownMenuEntry(
                                    value: company.id.toString(),
                                    label: company.title,
                                  );
                                }),
                              ],
                              onSelected: (id) {
                                productsApiProvider
                                    .fetchProducts(int.tryParse(id!) ?? 0);
                                reportValueController.selectedCompany.value =
                                    id;
                              },
                            ),
                            const Gap(10),
                            Obx(() {
                              switch (
                                  productsApiProvider.rxRequestStatus.value) {
                                case Status.loading:
                                  return const Expanded(
                                      child: Center(child: CustomLoading()));
                                case Status.error:
                                  return const RetryWidget();
                                case Status.initial:
                                  return CategoryDropdown(
                                    itemList: const [
                                      DropdownMenuEntry(
                                          value: 'الکل', label: 'الکل'),
                                    ],
                                    onSelected: (id) {
                                      reportValueController
                                          .selectedProduct.value = '0';
                                    },
                                  );
                                case Status.completed:
                                  return CategoryDropdown(
                                    itemList: [
                                      const DropdownMenuEntry(
                                          value: 'الکل', label: 'الکل'),
                                      ...productsApiProvider.productsDataList
                                          .map((company) {
                                        return DropdownMenuEntry(
                                          value: company.id.toString(),
                                          label: company.title,
                                        );
                                      }),
                                    ],
                                    onSelected: (String? id) {
                                      reportValueController
                                          .selectedProduct.value = id ?? '0';
                                    },
                                  );
                                default:
                                  return const Center(
                                      child: Text('Unknown state'));
                              }
                            }),
                          ],
                        ),
                        const Gap(10),
                        Obx(
                          () => ElevatedButton(
                            onPressed: reportListApiProvider
                                        .rxRequestButtonStatus.value ==
                                    Status.loading
                                ? null
                                : () {
                                    rePrintApiProvider.reportPrint.value = true;
                                    reportListApiProvider.fetchReportData(
                                      productId: reportValueController
                                          .selectedProduct.value,
                                      companyId: reportValueController
                                          .selectedCompany.value,
                                      startDate:
                                          reportValueController.startDate.value,
                                      endDate:
                                          reportValueController.endDate.value,
                                    );
                                  },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/paper-plane-top.svg',
                                  width: 20,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.onPrimary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  'ارسال',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const OfflineWidget(),
            ),
            const Gap(10),
            Obx(() {
              switch (reportListApiProvider.rxRequestStatus.value) {
                case Status.loading:
                  return const CustomLoading();
                case Status.error:
                  return RetryWidget(
                    onTap: () => reportListApiProvider.fetchReportData(
                      productId: reportValueController.selectedProduct.value,
                      companyId: reportValueController.selectedCompany.value,
                      startDate: reportValueController.startDate.value,
                      endDate: reportValueController.endDate.value,
                    ),
                  );
                case Status.completed:
                  if (reportListApiProvider
                      .reportDataList.first.serials.isEmpty) {
                    return const Center(
                      child: Text('لا توجد بيانات لعرضها'),
                    );
                  }
                  return reportListApiProvider.reportDataList.isNotEmpty
                      ? USerReportingList(
                          reportDataList: reportListApiProvider.reportDataList,
                        )
                      : const Text('لا توجد بيانات لعرضها');

                default:
                  return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
