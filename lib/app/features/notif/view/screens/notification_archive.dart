import 'package:flutter/material.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';

class NotificationArchive extends StatelessWidget {
  const NotificationArchive({super.key});

  @override
  Widget build(BuildContext context) {
    return InternalPage(
      title: 'الاشعارات',
      customWidget: Text('mohammad'),
    );
  }
}
