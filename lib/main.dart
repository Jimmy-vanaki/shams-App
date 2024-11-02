import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/theme.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shams/app/core/init/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      // dark
      darkTheme: MyThemes.darkTheme,
      // light
      theme: MyThemes.lightTheme,
      initialRoute: RoutesClass.getSplshRoute(),
      getPages: RoutesClass.routes,
    );
  }
}
