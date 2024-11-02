import 'package:get/get.dart';
import 'package:shams/app/features/login/view/screens/welcome_page.dart';
import 'package:shams/app/features/page_view/view/screens/main_page_view.dart';
import 'package:shams/app/features/intro/view/screens/onboarding_page.dart';
import 'package:shams/app/features/intro/view/screens/splash_page.dart';
import 'package:shams/app/features/notif/view/screens/notification_archive.dart';
import 'package:shams/app/features/text_content/view/screen/text_content.dart';

class RoutesClass {
  static String home = '/';
  static String splash = '/splash';
  static String intro = '/intro';
  static String notifArchive = '/notifArchive';
  static String welcomePage = '/welcomePage';
  static String textContent = '/textContent';

  static String getHomeRoute() => home;
  static String getSplshRoute() => splash;
  static String getIntroRoute() => intro;
  static String getNotifArchiveRoute() => notifArchive;
  static String getWelcomePage() => welcomePage;
  static String getTextContent() => textContent;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const MainPageView()),
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: intro, page: () => const IntroPage()),
    GetPage(name: notifArchive, page: () => const NotificationArchive()),
    GetPage(name: welcomePage, page: () => const WelcomePage()),
    GetPage(
        name: textContent, page:(){
           TextContent  content= Get.arguments;

           return content;
        }),
  ];
}
