import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/view/getX/company_archive_controller.dart';
import 'package:shams/app/features/home/view/screens/product_archive_page.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CompaniesArchivePage extends StatelessWidget {
  const CompaniesArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CompanyArchiveController companyArchiveController =
        Get.put(CompanyArchiveController());

    return InternalPage(
      title: 'بطاقاتنا',
      customWidget: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: Constants.shamsBoxDecoration(context),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                controller: companyArchiveController.searchController,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'search',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SvgPicture.asset(
                        'assets/svgs/search.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Obx(
                () => AutoHeightGridView(
                  itemCount: companyArchiveController.filteredCompanies.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  shrinkWrap: true,
                  builder: (context, index) {
                    return ZoomTapAnimation(
                      onTap: () {
                        Get.toNamed(
                          Routes.productArchivePage,
                          arguments: ProductArchivePage(
                            companyId: companyArchiveController
                                .filteredCompanies[index].id,
                            companyName: companyArchiveController
                                .filteredCompanies[index].title,
                          ),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: Constants.shamsBoxDecoration(context)
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                        child: Column(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.2),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 140,
                                imageUrl: companyArchiveController
                                    .filteredCompanies[index].logoUrl,
                                placeholder: (context, url) =>
                                    const CustomLoading(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/not.jpg',
                                  fit: BoxFit.fill,
                                  height: 160,
                                  width: 160,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              companyArchiveController
                                  .filteredCompanies[index].title,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
