import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';
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
                height: 160,
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
                      height: 100,
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
                                    '30 روزه',
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
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: const Text(
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
