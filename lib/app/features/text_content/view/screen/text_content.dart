import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shams/app/config/constants.dart';
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
      title: title,
      customWidget: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: Constants.shamsBoxDecoration(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const Gap(20),
                Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
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
