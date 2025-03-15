import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/config/functions.dart';
import 'package:shams/app/config/local_auth.dart';
import 'package:shams/app/config/status.dart';
import 'package:shams/app/core/utils/custom_loading.dart';
import 'package:shams/app/features/auth/data/data_source/singin_api_provider.dart';
import 'package:shams/app/features/auth/view/getX/welcome_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

final formKey = GlobalKey<FormState>();
FocusNode fildOne = FocusNode();
FocusNode fildTwo = FocusNode();
final WelcomeController welcomeController = Get.put(WelcomeController());
final SinginApiProvider singinApiProvider = Get.put(SinginApiProvider());

class Signin extends StatelessWidget {
  const Signin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userInfo = Constants.localStorage.read('userInfo');
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'مرحبًا بعودتك',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            const Gap(40),
            SvgPicture.asset(
              width: Get.width - 120,
              height: Get.height * 0.4,
              'assets/svgs/welcome/sign_in.svg',
            ),
            const Gap(40),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    focusNode: fildOne,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: singinApiProvider.usernameController,
                    validator: (value) {
                      if (GetUtils.isEmail(value!)) {
                        return null;
                      }
                      return 'أدخل بريد إلكتروني صالح';
                    },
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(fildTwo);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        'البريد الإلكتروني',
                      ),
                    ),
                  ),
                  const Gap(20),
                  Obx(
                    () => TextFormField(
                      focusNode: fildTwo,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: welcomeController.isPasswordHidden.value,
                      controller: singinApiProvider.passwordController,
                      validator: (value) {
                        if (value!.length > 5) {
                          return null;
                        }
                        return 'أدخل كلمة المرور الخاصة بك بشكل صحيح';
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                        )),
                        label: const Text(
                          'كلمة المرور',
                        ),
                        suffix: ZoomTapAnimation(
                          onTap: () {
                            welcomeController.isPasswordHidden.value =
                                !welcomeController.isPasswordHidden.value;
                          },
                          child: SvgPicture.asset(
                            welcomeController.isPasswordHidden.value
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
                  const Gap(20),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 55, 55, 55),
                          backgroundColor: _getBackgroundColor(
                              singinApiProvider.rxRequestStatus.value, context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed:
                            singinApiProvider.rxRequestButtonStatus.value ==
                                    Status.loading
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    if (formKey.currentState!.validate()) {
                                      singinApiProvider.login(
                                        username: singinApiProvider
                                            .usernameController.text,
                                        password: singinApiProvider
                                            .passwordController.text,
                                      );
                                    }
                                  },
                        child: Obx(
                          () {
                            switch (singinApiProvider.rxRequestStatus.value) {
                              case Status.completed:
                                return Text(
                                  'دخول',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                );
                              case Status.error:
                                return Text(
                                  singinApiProvider.errorMessage.value,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError,
                                  ),
                                );
                              case Status.loading:
                                return CustomLoading(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                );
                              default:
                                return const Text('دخول');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            if (userInfo != null)
              ZoomTapAnimation(
                onTap: () async {
                  final authenticate = await LocalAuth.authenticate();

                  if (authenticate) {
                    singinApiProvider.login(
                      username: userInfo['userName'],
                      password: userInfo['password'],
                    );
                  }
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      width: 40,
                      height: 40,
                      'assets/svgs/fingerprint.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Gap(5),
                    const Text('الدخول ببصمة اليد أو الوجه'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Color _getBackgroundColor(Status status, BuildContext context) {
  if (status == Status.error) {
    return Theme.of(context).colorScheme.error;
  }
  return Theme.of(context).colorScheme.primary;
}
