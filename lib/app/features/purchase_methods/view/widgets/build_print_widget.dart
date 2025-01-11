import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shams/app/config/functions.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/setting/view/getX/setting_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class PrintWidget extends StatelessWidget {
  const PrintWidget({
    super.key,
    required this.printDate,
    required this.serialId,
    required this.cardTitle,
    required this.serial,
    required this.pinCode,
    required this.code1,
    required this.code2,
    required this.code3,
    required this.code4,
    required this.photoUrl,
    required this.ussd,
    required this.footerText,
    required this.isReported,
    required this.cardPhotoScreenshotControllers,
    required this.headerScreenshotControllers,
    required this.qrcodeScreenshotControllers,
    required this.footerScreenshotControllers,
    required this.pinCodeScreenshotControllers,
  });
  final String printDate;
  final String serialId;
  final String cardTitle;
  final String serial;
  final String pinCode;
  final String photoUrl;
  final String footerText;
  final String ussd;
  final String code1;
  final String code2;
  final String code3;
  final String code4;
  final bool isReported;
  final ScreenshotController cardPhotoScreenshotControllers;
  final ScreenshotController headerScreenshotControllers;
  final ScreenshotController qrcodeScreenshotControllers;
  final ScreenshotController footerScreenshotControllers;
  final ScreenshotController pinCodeScreenshotControllers;
  @override
  Widget build(BuildContext context) {
    print('printDate=======>$printDate');
    final updateController = Get.find<UpdateController>();
    final user = updateController.userData.first;
    final settingController = Get.find<SettingController>();

    const double mainPadding = 3.0;
    const TextStyle boldTextStyle8 = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black);
    const TextStyle boldTextStyle10 = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black);
    return Container(
      padding: const EdgeInsets.all(mainPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Screenshot(
            controller: headerScreenshotControllers,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 70,
                      width: 60,
                      imageUrl: user.user?.agent?.appPhotoUrl ?? '',
                      placeholder: (context, url) => const CustomLoading(),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/not.jpg',
                        fit: BoxFit.fill,
                        height: 70,
                        width: 60,
                      ),
                    ),
                  ),
                  Text(user.user?.agent?.name ?? '', style: boldTextStyle8),
                  _buildLabeledContainer(user.user?.name ?? ''),
                ],
              ),
            ),
          ),
          isReported
              ? const Text('--------- 2 ---------', style: boldTextStyle10)
              : const SizedBox(),
          _buildAlignText(
              'Terminal ID : ${user.user?.id ?? ''}', boldTextStyle8),
          _buildAlignText('Time : $printDate', boldTextStyle8),
          _buildAlignText('Order Number :  $serialId', boldTextStyle8),
          const Gap(5),
          Visibility(
            visible: settingController.settings["printCardImage"] ?? false,
            child: SizedBox(
              height: 140,
              width: double.infinity,
              child: Screenshot(
                controller: cardPhotoScreenshotControllers,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: photoUrl,
                  placeholder: (context, url) => const CustomLoading(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/not.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Text(cardTitle, style: boldTextStyle10),
          const Gap(5),
          pinCode != ''
              ? Column(
                  children: [
                    _buildAlignText('serial : $serial', boldTextStyle8),
                    _buildAlignText(': Pin Code ', boldTextStyle8),
                    Screenshot(
                      controller: pinCodeScreenshotControllers,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          pinCode,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Screenshot(
                  controller: pinCodeScreenshotControllers,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Divider(),
                        Text(code1,
                            style: boldTextStyle10,
                            textAlign: TextAlign.center),
                        const Divider(),
                        Text(code2,
                            style: boldTextStyle10,
                            textAlign: TextAlign.center),
                        const Divider(),
                        Text(code3,
                            style: boldTextStyle10,
                            textAlign: TextAlign.center),
                        const Divider(),
                        Text(code4,
                            style: boldTextStyle10,
                            textAlign: TextAlign.center),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
          Visibility(
            visible: settingController.settings["printQrcode"] ?? false,
            child: Screenshot(
              controller: qrcodeScreenshotControllers,
              child: pinCode != ''
                  ? Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration:
                          (settingController.settings["printInformation"] ??
                                  false)
                              ? const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(bottom: BorderSide()))
                              : const BoxDecoration(color: Colors.white),
                      child: Center(
                        child: QrImageView(
                          data: "tel:$ussd",
                          version: QrVersions.auto,
                          size: 100.0,
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white,
                    ),
            ),
          ),
          Visibility(
            visible: settingController.settings["printInformation"] ?? false,
            child: footerText.isNotEmpty
                ? Screenshot(
                    controller: footerScreenshotControllers,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Html(
                          data: footerText,
                          style: {
                            "p": Style(
                              fontSize: FontSize(16),
                              color: Colors.black,
                            ),
                          },
                        ),
                        // child:
                        //  Text(
                        //   removeHtmlTags(
                        //     footerText,
                        //   ),
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.w700,
                        //     fontSize: 18,
                        //   ),
                        //   textAlign: TextAlign.left,
                        //   textDirection: TextDirection.ltr,
                        // ),
                      ),
                    ),
                  )
                : Screenshot(
                    controller: footerScreenshotControllers,
                    child: const Divider(
                      color: Colors.white,
                    ),
                  ),
          ),
          const Gap(4),
        ],
      ),
    );
  }

  Widget _buildLabeledContainer(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide()),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildAlignText(String text, TextStyle style) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: style),
    );
  }
}
