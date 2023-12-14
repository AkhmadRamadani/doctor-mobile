import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/models/responses/get_my_places_response.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/repositories/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePlaceController extends GetxController {
  static CreatePlaceController get to => Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  PlaceRepository _repository = PlaceRepository();

  RxBool isEdit = false.obs;
  ItemPlace? itemPlace;

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    if (data != null) {
      if (data is ItemPlace) {
        itemPlace = data;
        nameController.text = itemPlace?.name ?? '';
        addressController.text = itemPlace?.address ?? '';
        isEdit.value = true;
      }
    }
  }

  void createPlace() async {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Nama tempat tidak boleh kosong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (addressController.text.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Alamat tidak boleh kosong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (isEdit.value) {
      DialogService.showDialogChoice(
        title: 'Konfirmasi',
        description: 'Apakah anda yakin ingin mengubah tempat?',
        onTapPositiveButton: () async {
          Get.back();
          await updatePlaceChallenge();
        },
        onTapNegativeButton: () {
          Get.back();
        },
      );
    } else {
      DialogService.showDialogChoice(
        title: 'Konfirmasi',
        description: 'Apakah anda yakin ingin membuat tempat?',
        onTapPositiveButton: () async {
          Get.back();
          await createPlaceChallenge();
        },
        onTapNegativeButton: () {
          Get.back();
        },
      );
    }
  }

  Future<void> createPlaceChallenge() async {
    DialogService.showLoading();

    var res = await _repository.createPlace(
      name: nameController.text,
      address: addressController.text,
    );

    DialogService.closeLoading();

    if (res.statusCode != 201) {
      DialogService.showDialogProblem(
        title: 'Gagal Membuat Tempat',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 201) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Membuat Tempat',
        description: res.message ?? '',
        buttonOnTap: () {
          Get.close(2);
        },
      );
    }
  }

  Future<void> updatePlaceChallenge() async {
    DialogService.showLoading();

    var res = await _repository.updatePlace(
      id: itemPlace?.id ?? 0,
      name: nameController.text,
      address: addressController.text,
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Mengubah Tempat',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Mengubah Tempat',
        description: res.message ?? '',
        buttonOnTap: () {
          Get.close(2);
        },
      );
    }
  }

  void deletePlace() {
    DialogService.showDialogChoice(
      title: 'Konfirmasi',
      description: 'Apakah anda yakin ingin menghapus tempat?',
      onTapPositiveButton: () async {
        Get.back();
        await deletePlaceChallenge();
      },
      onTapNegativeButton: () {
        Get.back();
      },
    );
  }

  Future<void> deletePlaceChallenge() async {
    DialogService.showLoading();

    var res = await _repository.deletePlace(
      id: itemPlace?.id ?? 0,
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Menghapus Tempat',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Menghapus Tempat',
        description: res.message ?? '',
        buttonOnTap: () {
          Get.close(2);
        },
      );
    }
  }
}
