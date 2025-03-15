import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/local_auth.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/common/widgets/internal_page.dart';
import 'package:shams/app/core/data/data_source/update_info.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/home/data/data_source/home_api_provider.dart';
import 'package:shams/app/features/profile/data/data_source/edite_profile_api_provider.dart';
import 'package:shams/app/features/profile/view/getX/edit_profile_page_controller.dart';
import 'package:shams/app/features/profile/view/getX/user_location_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:geolocator/geolocator.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditProfilePageController());
    Get.lazyPut(() => EditeProfileApiProvider());
    final updateController = Get.find<HomeApiProvider>();
    final editProfilePageController = Get.find<EditProfilePageController>();
    final editeProfileApiProvider = Get.find<EditeProfileApiProvider>();
    final LocationController locationController = Get.put(LocationController());

    final formKey = GlobalKey<FormState>();

    final InputDecoration inputdecoration = InputDecoration(
      fillColor: Theme.of(context).colorScheme.primary.withAlpha(50),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    );
    return InternalPage(
      title: 'تعديل الملف الشخصي',
      customWidget: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 240),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Obx(() {
                        return TextFormField(
                          controller:
                              editProfilePageController.addressController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: null,
                          minLines: 1,
                          expands: false,
                          decoration: inputdecoration.copyWith(
                            hintText: 'العنوان',
                            suffixIcon: locationController
                                        .rxRequestStatus.value ==
                                    Status.loading
                                ? const CustomLoading()
                                : ZoomTapAnimation(
                                    onTap: () async {
                                      await locationController
                                          .getUserLocation();
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        'assets/svgs/land-layer-location.svg',
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).colorScheme.primary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      }),
                      const Gap(10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.length < 10 || value.length > 10) {
                            return 'رقم الجوال غير صالح';
                          }
                          return null;
                        },
                        controller: editProfilePageController.mobileController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: inputdecoration.copyWith(
                          hintText: 'الهاتف',
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText:
                              editProfilePageController.isPasswordHidden.value,
                          controller:
                              editProfilePageController.passwordController,
                          validator: (value) {
                            if (value!.length > 5 || value.isEmpty) {
                              return null;
                            }
                            return 'أدخل كلمة المرور الخاصة بك بشكل صحيح';
                          },
                          decoration: inputdecoration.copyWith(
                            hintText: 'كلمة المرور',
                            suffix: ZoomTapAnimation(
                              onTap: () {
                                editProfilePageController
                                        .isPasswordHidden.value =
                                    !editProfilePageController
                                        .isPasswordHidden.value;
                              },
                              child: SvgPicture.asset(
                                editProfilePageController.isPasswordHidden.value
                                    ? 'assets/svgs/eye.svg'
                                    : 'assets/svgs/eye-crossed.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText:
                              editProfilePageController.isPasswordHidden.value,
                          controller: editProfilePageController
                              .passwordConfirmController,
                          validator: (value) {
                            if (value!.length > 5 || value.isEmpty) {
                              return null;
                            }
                            return 'أدخل كلمة المرور الخاصة بك بشكل صحيح';
                          },
                          decoration: inputdecoration.copyWith(
                            hintText: 'تكرار كلمة المرور',
                            suffix: ZoomTapAnimation(
                              onTap: () {
                                editProfilePageController
                                        .isPasswordHiddenConfirm.value =
                                    !editProfilePageController
                                        .isPasswordHiddenConfirm.value;
                              },
                              child: SvgPicture.asset(
                                editProfilePageController
                                        .isPasswordHiddenConfirm.value
                                    ? 'assets/svgs/eye.svg'
                                    : 'assets/svgs/eye-crossed.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        'في حال الرغبة بتعديل كلمة المرور أدخل الرمز المناسب، وفي حال عدمها اترك الحقول فارغة',
                        style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(150)),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            print(editProfilePageController
                                .convertImageToBase64());
                            if (formKey.currentState!.validate()) {
                              if (editProfilePageController
                                      .passwordController.text.isNotEmpty &&
                                  editProfilePageController
                                      .passwordConfirmController
                                      .text
                                      .isNotEmpty) {
                                final authenticate =
                                    await LocalAuth.authenticate();
                                if (authenticate) {
                                  editeProfileApiProvider.updateProfile(
                                    address: editProfilePageController
                                        .addressController.text,
                                    mobile: editProfilePageController
                                        .mobileController.text,
                                    password: editProfilePageController
                                        .passwordController.text,
                                    passwordConfirmation:
                                        editProfilePageController
                                            .passwordConfirmController.text,
                                    photo: editProfilePageController
                                            .convertImageToBase64() ??
                                        '',
                                    lat: locationController.lat.value,
                                    lon: locationController.lon.value,
                                  );
                                }
                              }
                              editeProfileApiProvider.updateProfile(
                                address: editProfilePageController
                                    .addressController.text,
                                mobile: editProfilePageController
                                    .mobileController.text,
                                password: '',
                                passwordConfirmation: '',
                                photo: editProfilePageController
                                        .convertImageToBase64() ??
                                    '',
                                lat: locationController.lat.value,
                                lon: locationController.lon.value,
                              );
                            }
                          },
                          child: Obx(
                            () {
                              switch (editeProfileApiProvider
                                  .rxRequestStatus.value) {
                                case Status.loading:
                                  return Center(
                                      child: CustomLoading(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ));
                                case Status.error:
                                  return Text(
                                    editeProfileApiProvider.errorMessage.value,
                                  );
                                case Status.initial:
                                  return const Text('ارسال');
                                case Status.completed:
                                  return const Text('ارسال');
                                default:
                                  return const Center(
                                      child: Text('Unknown state'));
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //Avatar
          Positioned(
            top: 30,
            child: Column(
              children: [
                Text(
                  updateController.homeDataList.first.user?.name ?? '',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap(10),
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: editProfilePageController.pickedImageFile.value !=
                              null
                          ? Image.file(
                              editProfilePageController.pickedImageFile.value!,
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: editProfilePageController
                                  .networkImageUrl.value,
                              placeholder: (context, url) =>
                                  const CustomLoading(),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/profile.png',
                                fit: BoxFit.fill,
                                height: 160,
                                width: 160,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Gallery
          Positioned(
            top: 190,
            right: 120,
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: ZoomTapAnimation(
                onTap: () => editProfilePageController.pickImage(),
                child: SvgPicture.asset(
                  'assets/svgs/folder-camera.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
