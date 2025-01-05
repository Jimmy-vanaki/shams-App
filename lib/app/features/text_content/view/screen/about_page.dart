import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/utils/custom_loading.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Constants.isLoggedIn
                ? Obx(
                    () {
                      final updateController = Get.find<UpdateController>();
                      if (updateController.userData.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      final user = updateController.userData.first;
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          // Adjust the image height to a maximum and allow width to adapt dynamically
                          return CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 70, // Use maximum height of the parent
                            width: null, // Auto width; will adjust dynamically
                            imageUrl: user.user?.agent?.appPhotoUrl ?? '',
                            placeholder: (context, url) =>
                                const CustomLoading(),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/defultLogo.png',
                              fit: BoxFit.fill,
                              height: 70, // Maximum height for the error image
                              width: null, // Auto width for error image
                            ),
                          );
                        },
                      );
                    },
                  )
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                    child: Image.asset(
                      'assets/images/defultLogo.png',
                      fit: BoxFit.fill,
                      height: 70,
                      width: 80,
                    ),
                  ),
            const Gap(20),
            Obx(
              () {
                final updateController = Get.find<UpdateController>();
                if (updateController.userData.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Text(
                  (updateController.userData.first.user?.agent?.description !=
                              null &&
                          updateController.userData.first.user!.agent!
                              .description!.isNotEmpty)
                      ? updateController
                          .userData.first.user!.agent!.description!
                      : '''- نظام متكامل لبيع وتسويق البطاقات الالكترونية المحلية والعالمية متخصصة في مجال بطاقات تعبئة الأرصدة لمختلف الشركات المحلية والعالمية وأجهزة POS بمختلف أنواعها.
                          - لا يمكن الدخول للتطبيق لأكثر من جهاز إلا بعد تسجيل الخروج، مراعاة لمتطلبات الحماية والأمان.
                          - واجهة سهلة وعملية، تظهر الرصيد الكلي للمستخدم ، مع امكانية الشراء ، وعرض التقارير، والاعدادات ، والاطلاع على الاشعارات وامكانية تعديل كلمة المرور.
                          - عند اختيار فئة معينة وتحديد العدد المطلوب، بامكانك طباعة معلومات الكارت ، او مشاركته عبر برامج التواصل الاجتماعي، او ارساله كرسالة نصية (SMS).
                          - بامكان المستخدم الاطلاع على التقارير بشكل سهل وعملي، بتحديد كل او بعض الفئات ، وتحديد الفئات الفرعية ، واختيار التاريخ المطلوب، لتظهر النتائج. مع امكانية تكرار عملية الطباعة او المشاركة او ارسال الرسالة النصية، او طباعة التقرير التفصيلي مع بيان التاريخ والوقت والرقم التسلسلي.
                          - بامكان المستخدم تحديد نوع الطابعة وحفظها حتى لا يتم السؤال في كل عملية طباعة، وكذلك تفعيل او عدم تفعيل عرض كود الاستجابة السريع (QR code)، وتحديث بيانات المستخدم.
                          - يتوفر نسختين من تطبيق (الشمس) للاجهزة العاملة بنظام اندرويد سواء للموبايل أو الاجهزة اللوحية، وكذلك نسخة iOS للايفون والايباد.
                          ''',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    height: 2.5,
                  ),
                );
              },
            ),
            const Gap(60),
          ],
        ),
      ),
    );
  }
}
