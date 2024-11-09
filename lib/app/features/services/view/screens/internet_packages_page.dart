import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';
import 'package:shams/app/core/extensions/success_color_theme.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class InternetPackagesPage extends StatelessWidget {
  const InternetPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InternalPage(
        title: 'باقات',
        customWidget: Container(
          margin: const EdgeInsets.all(20),
          decoration: Constants.shamsBoxDecoration(context),
          child: Column(
            children: [
              const Gap(20),
              Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 2),
                  itemBuilder: (context, index) {
                    return ZoomTapAnimation(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration:
                            Constants.shamsBoxDecoration(context).copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: Center(
                          child: Text('MAX Cards'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(20),
              Container(
                height: 140,
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(40)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'باقات مقترحة',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Gap(10),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ZoomTapAnimation(
                            child: Container(
                              width: 150,
                              margin:
                                  const EdgeInsets.only(left: 10, bottom: 2),
                              padding: const EdgeInsets.all(10),
                              decoration: Constants.shamsBoxDecoration(context)
                                  .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                border: Border(
                                  right: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withAlpha(50),
                                    width: 8,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Monthly 50GB',
                                  ),
                                  Text(
                                    '19,500 IQD',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(15),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    'الباقات',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const Gap(5),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ZoomTapAnimation(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          showDragHandle: true,
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                alignment: Alignment.topCenter,
                                height: Get.height * .4,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      textDirection: TextDirection.ltr,
                                      validator: (value) {
                                        if (value!.length < 12) {
                                          return null;
                                        }
                                        return 'رقم الجوال غير صالح';
                                      },
                                      initialValue: ' ',
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        suffixText: '00964',
                                        suffixStyle: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withAlpha(200)),
                                        border: OutlineInputBorder(),
                                        label: Text(
                                          'رقم الهاتف',
                                        ),
                                      ),
                                    ),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('شرکت :'),
                                        Text('MAX Cards'),
                                      ],
                                    ),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('مبلغ :'),
                                        Text('20,000 IQD'),
                                      ],
                                    ),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('زمان :'),
                                        Text('Monthly'),
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Theme.of(context)
                                                        .extension<
                                                            SuccessColorTheme>()
                                                        ?.successColor),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'تاکید',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .extension<
                                                      SuccessColorTheme>()
                                                  ?.onSuccessColor,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 18),
                        decoration: Constants.shamsBoxDecoration(context)
                            .copyWith(
                                boxShadow: [],
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('Monthly 30GB')),
                            Text('20,000IQD'),
                            const Gap(5),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: SvgPicture.asset(
                                'assets/svgs/angle-left.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                                width: 12,
                                height: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
