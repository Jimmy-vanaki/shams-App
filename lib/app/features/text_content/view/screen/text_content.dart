import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/core/common/widgets/appbar.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';

class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    required this.title,
    required this.text,
  });
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InternalPage(
      customWidget: Container(
        margin: EdgeInsets.all(20),
        decoration: Constants.shamsBoxDecoration(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const Gap(20),
                Text(
                  '''
        لوريم إيبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من الزمن لم تقضي على هذا النص، بل انه حتى صار مستخدماً وبشكله الأصلي في الطباعة والتنضيد الإلكتروني. انتشر بشكل كبير في ستينيّات هذا القرن مع إصدار رقائق "ليتراسيت" البلاستيكية تحوي مقاطع من هذا النص، وعاد لينتشر مرة أخرى مؤخراَ مع ظهور برامج النشر الإلكتروني مثل "ألدوس بايج مايكر" والتي حوت أيضاً على نسخ من نص لوريم إيبسوم.



              ''' +
                      text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 2.5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
