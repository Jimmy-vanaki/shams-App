import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shams/app/core/common/widgets/appbar.dart';

class NotificationArchive extends StatelessWidget {
  const NotificationArchive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: shamsAppbar(context),
      body: Center(
        child: Text('Notification'),
      ),
    );
  }
}
