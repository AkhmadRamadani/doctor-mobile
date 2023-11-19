import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/settings/repositories/private_information_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivateInformationController extends GetxController {
  static PrivateInformationController get to => Get.find();

  TextEditingController pinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  PrivateInformationRepository repository = PrivateInformationRepository();

  User? user;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> getUser() async {
    user = await repository.getCurrentUser();
    update(['pin']);
  }

  void updateAccessCode({bool isForgetPin = false}) async {
    if (!isForgetPin) {
      if (pinController.text.isEmpty ||
          newPinController.text.isEmpty ||
          confirmPinController.text.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Semua field harus diisi',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (newPinController.text != confirmPinController.text) {
        Get.snackbar(
          'Gagal',
          'Konfirmasi PIN tidak sesuai',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    } else {
      if (birthDateController.text.isEmpty ||
          newPinController.text.isEmpty ||
          confirmPinController.text.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Semua field harus diisi',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (newPinController.text != confirmPinController.text) {
        Get.snackbar(
          'Gagal',
          'Konfirmasi PIN tidak sesuai',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }

    DialogService.showDialogChoice(
      title: 'Ubah PIN',
      description: 'Apakah anda yakin ingin mengubah PIN?',
      onTapNegativeButton: () => Get.back(),
      onTapPositiveButton: () {
        Get.back();
        updateAccessCodeChallenge(
          isForgetPin: isForgetPin,
        );
      },
      textNegativeButton: 'Tidak',
      textPositiveButton: 'Ya',
    );
  }

  Future<void> updateAccessCodeChallenge({bool isForgetPin = false}) async {
    DialogService.showLoading();

    var res = await repository.updateAccessCode(
      accessCode: int.tryParse(newPinController.text),
      oldAccessCode: int.tryParse(pinController.text),
      isForgetPin: isForgetPin,
      birthDate: int.tryParse(birthDateController.text),
    );

    DialogService.closeLoading();

    if (res.statusCode == 200) {
      Get.back();

      pinController.clear();
      newPinController.clear();
      confirmPinController.clear();
      birthDateController.clear();

      DialogService.showDialogSuccess(
        title: 'Berhasil',
        description: 'PIN berhasil diubah',
      );
    } else {
      Get.back();
      DialogService.showDialogProblem(
        title: 'Gagal',
        description: res.message ?? 'Terjadi kesalahan saat mengubah PIN',
      );
    }
  }

  void updatePassword() {
    if (passwordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Semua field harus diisi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPasswordController.text != confirmNewPasswordController.text) {
      Get.snackbar(
        'Gagal',
        'Konfirmasi password tidak sesuai',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    DialogService.showDialogChoice(
      title: 'Ubah Password',
      description: 'Apakah anda yakin ingin mengubah password?',
      onTapNegativeButton: () => Get.back(),
      onTapPositiveButton: () {
        Get.back();
        updatePasswordChallenge();
      },
      textNegativeButton: 'Tidak',
      textPositiveButton: 'Ya',
    );
  }

  Future<void> updatePasswordChallenge() async {
    DialogService.showLoading();

    var res = await repository.updatePassword(
      oldPassword: passwordController.text,
      newPassword: newPasswordController.text,
    );

    DialogService.closeLoading();

    if (res.statusCode == 200) {
      Get.back();

      passwordController.clear();
      newPasswordController.clear();
      confirmNewPasswordController.clear();

      DialogService.showDialogSuccess(
        title: 'Berhasil',
        description: 'Password berhasil diubah',
      );
    } else {
      Get.back();
      DialogService.showDialogProblem(
        title: 'Gagal',
        description: res.message ?? 'Terjadi kesalahan saat mengubah password',
      );
    }
  }

  void showDialogChangePassword() {
    Get.bottomSheet(
      _showPasswordModal(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Container _showPasswordModal() {
    return Container(
      height: 0.5.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: ColorConst.gradient3,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Ganti Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password Lama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: newPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Password Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmNewPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Konfirmasi Password Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      updatePassword();
                    },
                    child: Container(
                      width: 1.sw,
                      height: 32.h,
                      decoration: BoxDecoration(
                        gradient: ColorConst.gradient3,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showDialogChangePin({bool isForgetPin = false}) {
    Get.bottomSheet(
      isForgetPin
          ? _showForgetPinModal()
          : (user?.accessCode == null
              ? _showCreatePinModal()
              : _showPinModalUpdate()),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Container _showForgetPinModal() {
    return Container(
      height: 0.55.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: ColorConst.gradient3,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Lupa Pin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: birthDateController,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Lahir',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 1.sw,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ColorConst.complementary50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: ColorConst.complementary500,
                          size: 16.sp,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Text(
                            'Masukkan Tanggal Lahir dengan Format YYYYMMDD, \nContoh: 19901231',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorConst.complementary500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: newPinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'PIN Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Konfirmasi PIN Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      updateAccessCode(isForgetPin: true);
                    },
                    child: Container(
                      width: 1.sw,
                      height: 32.h,
                      decoration: BoxDecoration(
                        gradient: ColorConst.gradient3,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _showCreatePinModal() {
    return Container(
      height: 0.5.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: ColorConst.gradient3,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Buat Pin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: newPinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'PIN Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Konfirmasi PIN Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      createAccessCode();
                    },
                    child: Container(
                      width: 1.sw,
                      height: 32.h,
                      decoration: BoxDecoration(
                        gradient: ColorConst.gradient3,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> createAccessCode() async {
    if (newPinController.text.isEmpty || confirmPinController.text.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Semua field harus diisi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPinController.text != confirmPinController.text) {
      Get.snackbar(
        'Gagal',
        'Konfirmasi PIN tidak sesuai',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    DialogService.showDialogChoice(
      title: 'Buat PIN',
      description: 'Apakah anda yakin ingin membuat PIN?',
      onTapNegativeButton: () => Get.back(),
      onTapPositiveButton: () {
        Get.back();
        createAccessCodeChallenge();
      },
      textNegativeButton: 'Tidak',
      textPositiveButton: 'Ya',
    );
  }

  Future<void> createAccessCodeChallenge() async {
    DialogService.showLoading();

    var res = await repository.updateAccessCode(
      accessCode: int.tryParse(newPinController.text),
    );

    DialogService.closeLoading();

    if (res.statusCode == 200) {
      Get.back();

      newPinController.clear();
      confirmPinController.clear();

      DialogService.showDialogSuccess(
        title: 'Berhasil',
        description: 'PIN berhasil dibuat',
      );
    } else {
      Get.back();
      DialogService.showDialogProblem(
        title: 'Gagal',
        description: res.message ?? 'Terjadi kesalahan saat membuat PIN',
      );
    }
  }

  Container _showPinModalUpdate() {
    return Container(
      height: 0.5.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: ColorConst.gradient3,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Ganti Pin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: pinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'PIN Lama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: newPinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'PIN Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Konfirmasi PIN Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      updateAccessCode();
                    },
                    child: Container(
                      width: 1.sw,
                      height: 32.h,
                      decoration: BoxDecoration(
                        gradient: ColorConst.gradient3,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
