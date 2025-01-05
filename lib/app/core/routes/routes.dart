import 'package:get/get.dart';
import 'package:shams/app/features/home/bindings/home_binding.dart';
import 'package:shams/app/features/home/view/screens/companies_archive_page.dart';
import 'package:shams/app/features/home/view/screens/product_archive_page.dart';
import 'package:shams/app/features/auth/view/screens/welcome_page.dart';
import 'package:shams/app/features/page_view/view/screens/main_page_view.dart';
import 'package:shams/app/features/intro/view/screens/onboarding_page.dart';
import 'package:shams/app/features/intro/view/screens/splash_page.dart';
import 'package:shams/app/features/notif/view/screens/notification_archive.dart';
import 'package:shams/app/features/profile/view/screens/edit_profile_page.dart';
import 'package:shams/app/features/profile/view/screens/profile_page.dart';
import 'package:shams/app/features/purchase_methods/view/screens/bluetooth_page.dart';
import 'package:shams/app/features/reporting/view/screens/reporting_topup.dart';
import 'package:shams/app/features/services/view/screens/internet_packages_page.dart';
import 'package:shams/app/features/services/view/screens/invoice_page.dart';
import 'package:shams/app/features/text_content/view/screen/text_content.dart';
import 'package:shams/app/features/user_operations/view/screen/user_operation.dart';

class Routes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String intro = '/intro';
  static const String notifArchive = '/notifArchive';
  static const String welcomePage = '/welcomePage';
  static const String textContent = '/textContent';
  static const String profilePage = '/profilePage';
  static const String editProfilePage = '/editProfilePage';
  static const String invoicePage = '/invoicePage';
  static const String internetPackagesPage = '/internetPackagesPage';
  static const String productArchivePage = '/productArchivePage';
  static const String companiesArchivePage = '/companiesArchivePage';
  static const String bluetoothPage = '/bluetoothPage';
  static const String reportingTopup = '/reportingTopup';
  static const String userOperation = '/userOperation';

  static final List<GetPage> pages = [
    GetPage(name: reportingTopup, page: () => const ReportingTopup()),
    GetPage(
        name: home, page: () => const MainPageView(), binding: HomeBinding()),
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: intro, page: () => const IntroPage()),
    GetPage(name: notifArchive, page: () => const NotificationArchive()),
    GetPage(name: userOperation, page: () => const UserOperation()),
    GetPage(name: welcomePage, page: () => const WelcomePage()),
    GetPage(name: profilePage, page: () => const ProfilePage()),
    GetPage(name: editProfilePage, page: () => const EditProfilePage()),
    GetPage(
        name: companiesArchivePage,
        page: () => const CompaniesArchivePage(),
        binding: HomeBinding()),

    GetPage(
        name: internetPackagesPage, page: () => const InternetPackagesPage()),
    GetPage(
        name: userOperation, page: () => const UserOperation()),
    // GetPage(name: invoicePage, page: () => const InvoicePage()),

    GetPage(
      name: invoicePage,
      page: () {
        final InvoicePage type = Get.arguments;
        return type;
      },
    ),
    GetPage(
      name: bluetoothPage,
      page: () {
        final BluetoothPage serialList = Get.arguments;
        return serialList;
      },
    ),

    GetPage(
      name: productArchivePage,
      page: () {
        final ProductArchivePage content = Get.arguments;
        return content;
      },
    ),
    GetPage(
      name: textContent,
      page: () {
        final TextContent content = Get.arguments;
        return content;
      },
    ),
  ];
}
