import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/modules/doctor/constants/doctor_routes_const.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/models/response/get_all_icds_response.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/repositories/medical_record_repository.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/models/responses/get_all_reservations_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalRecordController extends GetxController {
  static MedicalRecordController get to => Get.find();

  TextEditingController icdController = TextEditingController();
  TextEditingController complaintController = TextEditingController();
  TextEditingController handlingController = TextEditingController();
  TextEditingController physicalExaminationController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController recommendationController = TextEditingController();
  TextEditingController recipeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  final MedicalRecordRepository _repository = MedicalRecordRepository();

  ItemAllReservations? itemAllReservations;
  ItemIcds? selectedIcds;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null && args is ItemAllReservations) {
      itemAllReservations = args;
    }
  }

  void selectIcdCode() async {
    var data = await Get.toNamed(
      DoctorRoutesConst.selectIcds,
    );

    if (data != null) {
      selectedIcds = data;
      icdController.text = '${data.code} - ${data.nameId}';
    }
  }

  void createMedicalRecord() {
    if (complaintController.text.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Mohon isi keluhan terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (handlingController.text.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Mohon isi tindakan terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (physicalExaminationController.text.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Mohon isi pemeriksaan fisik terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (diagnosisController.text.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Mohon isi diagnosa terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (recommendationController.text.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Mohon isi anjuran terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (recipeController.text.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Mohon isi resep terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    DialogService.showDialogChoice(
      title: 'Konfirmasi',
      description: 'Apakah anda yakin ingin membuat rekam medis ini?',
      onTapPositiveButton: () {
        Get.back();
        createMedicalRecordChallenge();
      },
      onTapNegativeButton: () {
        Get.back();
      },
    );
  }

  Future<void> createMedicalRecordChallenge() async {
    DialogService.showLoading();

    var res = await _repository.createMedicalRecord(
      reservationId: itemAllReservations?.id ?? 0,
      icdCode: selectedIcds?.code ?? '',
      complaint: complaintController.text,
      action: handlingController.text,
      physicalExam: physicalExaminationController.text,
      diagnosis: diagnosisController.text,
      recommendation: recommendationController.text,
      recipe: recipeController.text,
      desc: noteController.text,
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Membuat Rekam Medis',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Membuat Rekam Medis',
        description: res.message ?? '',
        buttonOnTap: () {
          Get.close(3);
        },
      );
    }
  }
}
