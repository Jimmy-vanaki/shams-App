import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shams/app/core/common/widgets/appbar.dart';

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
    return Scaffold(
      appBar: shamsAppbar(context),
      body: Padding(
        padding: EdgeInsets.all(20),
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
        شركة متخصصة في مجال أنظمة بيع وتوزيع البطاقات الرقمية والخدمات الالكترونية، تتميز بطاقم اداري متخصص وذو خبرة واسعة في هذا المجال لتصبح بذلك واحدة من أفضل الشركات في المنطقة.
      شركة متخصصة في مجال أنظمة بيع وتوزيع البطاقات الرقمية والخدمات الالكترونية، تتميز بطاقم اداري متخصص وذو خبرة واسعة في هذا المجال لتصبح بذلك واحدة من أفضل الشركات في المنطقة.
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
    );
  }
}
