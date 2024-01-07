import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/core/services/messaging_service.dart';
import 'package:doctor_mobile/modules/login/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LoginRepository _loginRepository = LoginRepository();

  void loginChallenge() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan password tidak boleh kosong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    DialogService.showLoading();

    var response = await _loginRepository.login(
      emailController.text,
      passwordController.text,
    );

    DialogService.closeLoading();

    if (response.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Login Gagal',
        description: response.message ??
            'Terjadi kesalahan saat login, silahkan coba lagi.',
        buttonOnTap: () {
          Get.back();
        },
      );

      return;
    }

    MessagingService().subscribeToTopic(response.user!.id!.toString());

    Get.offAllNamed(AppRoutes.dashboard);
  }

  void register() {
    Get.toNamed(AppRoutes.register);
  }
}
