import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:doctor_mobile/core/services/messaging_service.dart';
import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/profile/models/presentation_models/user_profile_model.dart';
import 'package:doctor_mobile/modules/profile/models/responses/get_current_user_response.dart';
import 'package:doctor_mobile/modules/profile/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController genderTextController = TextEditingController();
  TextEditingController birthDateTextController = TextEditingController();
  TextEditingController pinTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();

  ProfileRepository repository = ProfileRepository();

  Rx<UIStateModel<UserProfileModel>> userProfileState =
      const UIStateModel<UserProfileModel>.idle().obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  DateTime? selectedBirthDate;

  Future<void> getUserProfileChallenge() async {
    userProfileState.value = const UIStateModel<UserProfileModel>.loading();

    GetCurrentUserResponse response = await repository.getUserProfile();

    if (response.statusCode != 200) {
      userProfileState.value = UIStateModel<UserProfileModel>.error(
        message: response.message ??
            'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }

    UserProfileModel data = UserProfileModel(
      name: response.data?.name ?? '',
      email: response.data?.email ?? '',
      phone: response.data?.phone ?? '',
      birthDate: DateTime.parse(response.data?.birthDate ?? '')
          .add(const Duration(hours: 7)),
      gender: response.data?.gender ?? '',
      address: response.data?.address ?? '',
    );

    userProfileState.value = UIStateModel<UserProfileModel>.success(data: data);

    nameTextController.text = data.name;
    phoneTextController.text = data.phone;
    emailTextController.text = data.email;
    genderTextController.text = data.gender;
    birthDateTextController.text = data.birthDate.toHumanReadableDateString();
    selectedBirthDate = data.birthDate;
    addressTextController.text = data.address;

    refreshController.refreshCompleted();
  }

  void updateProfile() {
    DialogService.showDialogChoice(
      title: 'Konfirmasi',
      description: 'Apakah anda yakin ingin mengubah data anda?',
      onTapPositiveButton: () async {
        Get.back();
        await updateProfileChallenge();
      },
      onTapNegativeButton: () {
        Get.back();
      },
    );
  }

  Future<void> updateProfileChallenge() async {
    DialogService.showLoading();

    var res = await repository.updateProfile(
      name: nameTextController.text,
      email: emailTextController.text,
      phone: phoneTextController.text,
      address: addressTextController.text,
      birthDate: selectedBirthDate?.toIso8601String(),
      gender: genderTextController.text,
    );

    DialogService.closeLoading();

    if ((res.statusCode ?? 0) >= 200 && (res.statusCode ?? 0) < 300) {
      DialogService.showDialogSuccess(
        title: 'Berhasil',
        description: 'Berhasil mengubah data anda',
      );
      getUserProfileChallenge();
    } else {
      DialogService.showDialogProblem(
        title: 'Gagal',
        description: res.message ?? 'Terjadi kesalahan saat mengubah data anda',
      );
    }
  }

  void logout() async {
    DialogService.showDialogChoice(
      title: 'Konfirmasi',
      description: 'Apakah anda yakin ingin keluar?',
      onTapPositiveButton: () async {
        await logoutChallenge();
      },
      onTapNegativeButton: () {
        Get.back();
      },
    );
  }

  Future<void> logoutChallenge() async {
    DialogService.showLoading();

    DefaultResponseHelper response = await repository.logout();
    User user = await repository.getCurrentUser();
    MessagingService().unsubscribeFromTopic(user.id.toString());
    DialogService.closeLoading();

    if (response.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Logout Gagal',
        description: response.message ??
            'Terjadi kesalahan saat logout, silahkan coba lagi.',
        buttonOnTap: () {
          Get.back();
        },
      );

      return;
    }

    await HiveService().clear();
    Get.offAllNamed('/login');
  }

  @override
  void onInit() {
    super.onInit();
    getUserProfileChallenge();
  }

  void selectDate(BuildContext context) async {
    DateTime? result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (result != null) {
      birthDateTextController.text = result.toHumanReadableDateString();
      selectedBirthDate = result;
      update(['birthDateText']);
    }
  }

  void selectGender(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 180.h,
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
                        'Jenis Kelamin',
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
              ListTile(
                title: const Text('Pria'),
                onTap: () {
                  genderTextController.text = 'Pria';
                  update(['genderText']);
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Wanita'),
                onTap: () {
                  genderTextController.text = 'Wanita';
                  update(['genderText']);
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
