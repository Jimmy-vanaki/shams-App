import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:shams/app/core/init/init.dart';
import 'package:shams/app/core/notif/firebase_notification_service.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/main.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    
    await init();
    await checkGooglePlayServices();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

Future<void> checkGooglePlayServices() async {
  GooglePlayServicesAvailability availability = await GoogleApiAvailability
      .instance
      .checkGooglePlayServicesAvailability();

  if (availability != GooglePlayServicesAvailability.success) {
    debugPrint('Google Play Services not available: $availability');
    // در صورت عدم وجود Google Play Services به کاربر اطلاع دهید
    Get.defaultDialog(
      title: "تنبيه",
      backgroundColor: Colors.white,
      content: Column(
        children: [
          Text(
              'قد لا تكون خدمات Google Play مثبتة على الجهاز (للأجهزة القديمة أو الصينية) إذا لم تكن هذه الخدمة متاحة، فسيتأثر أداء Firebase والاشعارات.'),
          const Gap(5),
          CustomLoading(),
          const Gap(5),
          Text('يرجى الانتظار ..')
        ],
      ),
    );
  } else {
    debugPrint('Google Play Services is available.');
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(handleFirebaseBackgroundMessage);
    await FirebaseNotificationService().initializeNotifications();
  }
}
