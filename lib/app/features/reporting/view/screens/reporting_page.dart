import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/features/reporting/view/widgets/date.dart';
import 'package:shams/app/features/reporting/view/widgets/user_reporting_list.dart';

class ReportingPage extends StatelessWidget {
  const ReportingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 200,
              width: Get.width,
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/checklist-task-budget.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'التقارير',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: USerReportingList(),
          ),
          Positioned(
            top: 60,
            child: Container(
              alignment: Alignment.center,
              height: 160,
              width: Get.width - 40,
              padding: const EdgeInsets.all(20),
              decoration: Constants.shamsBoxDecoration(context),
              child: Column(
                children: [
                  ReportingDate(),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {},
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
