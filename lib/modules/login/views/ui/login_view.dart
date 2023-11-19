import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: false, // new line
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 72.h,
              ),
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: ColorConst.primary500),
              ),
              SizedBox(
                height: 72.h,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConst.primary500,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConst.primary500,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: ColorConst.primary500,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConst.primary500,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConst.primary500,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: ColorConst.primary500,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: const Text(
                    //         'Lupa Password?',
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w400,
                    //           color: ColorConst.primary500,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 48,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.loginChallenge();
                      },
                      child: Container(
                        width: 1.sw,
                        height: 48,
                        decoration: BoxDecoration(
                          color: ColorConst.primary500,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.register);
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'Belum punya akun? ',
                          style: TextStyle(
                              color: ColorConst.primary500,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: 'Buat Akun',
                              style: TextStyle(
                                  color: ColorConst.primary500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
