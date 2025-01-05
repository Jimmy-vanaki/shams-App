import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/core/common/constants/dashed_border.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/routes/routes.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/purchase_methods/view/screens/bluetooth_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

Future<void> manageMethods({
  required int type,
  required List? serials,
  required String cardTitle,
  required String photoUrl,
  required List? ussdCodes,
  required String printDate,
  required String title,
  required String footer,
  required bool isReported,
}) async {
  final updateController = Get.find<UpdateController>();
  String generatePinCodes() {
    final StringBuffer buffer = StringBuffer();
    if (serials?.first.code != null) {
      for (var serial in serials!) {
        buffer.writeln('الفئة: $cardTitle');
        buffer.writeln('Pin Code: ${serial.code}');
        buffer.writeln('Serial: ${serial.serial}');
        buffer.writeln('----------------------');
      }
    } else {
      for (var serial in serials!) {
        buffer.writeln('الفئة: $cardTitle');
        buffer.writeln('${serial.code1}');
        buffer.writeln('${serial.code2}');
        buffer.writeln('${serial.code3}');
        buffer.writeln('${serial.code4}');
        buffer.writeln('----------------------');
      }
    }

    buffer.writeln(
        'أرسل بواسطة: ${updateController.userData.first.user?.name ?? ''}');
    return buffer.toString();
  }

  String generateScreenCode() {
    // final serials = purchaseApiProvider.purchaseDataList.first.serials;
    final StringBuffer buffer = StringBuffer();
    if (serials?.first.code != null && serials?.first.code != '') {
      for (var serial in serials!) {
        buffer.writeln('${serial.code}');
        buffer.writeln('${serial.serial}');
        buffer.write('------------------');
      }
    } else {
      buffer.writeln('${serials?.first.code1}');
      buffer.writeln('${serials?.first.code2}');
      buffer.writeln('${serials?.first.code3}');
      buffer.writeln('${serials?.first.code4}');
    }

    return buffer.toString();
  }

  print('ussdCodes----->${ussdCodes?.first.code}');
  switch (type) {
    case 0: // Print
      Get.toNamed(
        Routes.bluetoothPage,
        arguments: BluetoothPage(
          serialList: serials ?? [],
          ussdCodes: ussdCodes ?? [],
          photoUrl: photoUrl,
          printDate: printDate,
          cardTitle: cardTitle,
          footer: footer,
          isReported: isReported,
        ),
      );
      break;

    case 1: // Share
      Share.share(generatePinCodes(), subject: 'Check this out!');
      break;

    case 2: // Screenshot
      final screenshotController = ScreenshotController();
      Future<void> saveAndShare(Uint8List image) async {
        final tempDir = await getTemporaryDirectory();
        final file =
            await File('${tempDir.path}/screenshot.png').writeAsBytes(image);
        final xFile = XFile(file.path);
        // Share the XFile
        await Share.shareXFiles(
          [xFile],
          text:
              'أرسل بواسطة: ${updateController.userData.first.user?.name ?? ''}',
        );
      }
      // Implement screenshot functionality
      Get.defaultDialog(
        title: "تنبيه",
        backgroundColor: Colors.white,
        content: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    height: 170,
                    imageUrl: photoUrl,
                    placeholder: (context, url) => const CustomLoading(),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/not.jpg',
                      fit: BoxFit.fill,
                      height: 170,
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: serials?.isNotEmpty == true &&
                            serials?.first.code?.isNotEmpty == true
                        ? serials!.map((serial) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              padding: const EdgeInsets.all(6),
                              child: DashedBorder(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Code: ${serial.code},\nSerial: ${serial.serial}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ),
                            );
                          }).toList()
                        : [
                            Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              padding: const EdgeInsets.all(6),
                              child: DashedBorder(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Code1: ${serials?.first.code1 ?? 'N/A'}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                      Text(
                                        'Code2: ${serials?.first.code2 ?? 'N/A'}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                      Text(
                                        'Code3: ${serials?.first.code3 ?? 'N/A'}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                      Text(
                                        'Code4: ${serials?.first.code4 ?? 'N/A'}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              Get.back();
              final Uint8List? image = await screenshotController.capture();
              if (image != null) {
                await saveAndShare(image);
              }
              Get.back();
            },
            child: const Text(
              'مشاركة الصورة',
            ),
          ),
        ],
      );

      break;

    case 3: // Copy to Clipboard
      await Clipboard.setData(ClipboardData(text: generatePinCodes()));
      break;

    case 4: // Direct Charging
      await _callNumber(ussdCodes?.first.code ?? '');
      break;

    case 5: // SMS
      _sendSMS(generatePinCodes(), []);
      break;

    default:
      debugPrint("Invalid type: $type");
  }
}

Future<void> _callNumber(String ussd) async {
  await FlutterPhoneDirectCaller.callNumber(ussd);
}

void _sendSMS(String message, List<String> recipients) async {
  try {
    String result = await sendSMS(message: message, recipients: recipients);
    debugPrint(result);
  } catch (error) {
    debugPrint("Error sending SMS: $error");
  }
}
