import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/connectivity_controller.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/theme.dart';
import 'package:shams/app/core/notif/firebase_notification_service.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shams/app/core/init/init.dart';
import 'package:google_api_availability/google_api_availability.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await init();
  await checkGooglePlayServices();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //connectivity controller
    Get.put(ConnectivityController());
    final bool darkMode =
        Constants.localStorage.read('settings')?['darkMode'] ?? false;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: const Locale('ar'),
      title: Constants.appTitle,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: MyThemes.darkTheme,
      theme: MyThemes.lightTheme,
      initialRoute: Routes.splash,
      getPages: Routes.pages,
    );
  }
}

Future<void> checkGooglePlayServices() async {
  GooglePlayServicesAvailability availability = await GoogleApiAvailability
      .instance
      .checkGooglePlayServicesAvailability();

  if (availability != GooglePlayServicesAvailability.success) {
    debugPrint('Google Play Services not available: $availability');
    // در صورت عدم وجود Google Play Services به کاربر اطلاع دهید
    showGooglePlayServicesError(availability);
  } else {
    debugPrint('Google Play Services is available.');
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(handleFirebaseBackgroundMessage);
    await FirebaseNotificationService().initializeNotifications();
  }
}

void showGooglePlayServicesError(GooglePlayServicesAvailability availability) {
  // اینجا می‌توانید با استفاده از دیالوگ یا صفحه جدید به کاربر اطلاع دهید.
  debugPrint(
      'Google Play Services is not available: ${availability.toString()}');
}
