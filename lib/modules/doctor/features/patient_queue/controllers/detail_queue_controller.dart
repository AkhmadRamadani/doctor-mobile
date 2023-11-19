import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/modules/doctor/constants/doctor_routes_const.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/models/responses/get_all_reservations_response.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/repositories/patient_queue_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailQueueController extends GetxController {
  static DetailQueueController get to => Get.find();

  ItemAllReservations? item;

  final PatientQueueRepository _repository = PatientQueueRepository();
  TextEditingController noteController = TextEditingController();

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null && args is ItemAllReservations) {
      item = args;
    }
    super.onInit();
  }

  void finishQueue() {
    DialogService.showDialogChoice(
      description: 'Apakah anda yakin ingin menyelesaikan antrian ini?',
      textNegativeButton: 'Tidak',
      textPositiveButton: 'Ya',
      onTapNegativeButton: () => Get.back(),
      onTapPositiveButton: () {
        Get.back();
        Get.toNamed(
          DoctorRoutesConst.medicalRecord,
          arguments: item,
        );
      },
    );
  }

  void approveQueue() {
    DialogService.showDialogChoice(
      description: 'Apakah anda yakin ingin menerima antrian ini?',
      textNegativeButton: 'Tidak',
      textPositiveButton: 'Ya',
      onTapNegativeButton: () => Get.back(),
      onTapPositiveButton: () {
        Get.back();
        approveQueueChallenge();
      },
    );
  }

  Future<void> approveQueueChallenge() async {
    DialogService.showLoading();

    var res = await _repository.approveOrRejectReservation(
      reservationId: item?.id ?? 0,
      status: 1,
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Menerima Antrian',
        description: res.message ?? 'Terjadi kesalahan saat menerima antrian.',
      );
      return;
    }

    await DialogService.showDialogSuccess(
      title: 'Berhasil Menerima Antrian',
      description: 'Antrian berhasil diterima.',
    );

    Get.back();
  }

  void rejectQueue() {
    // show dialog to input note
    DialogService.showDialogInput(
      title: 'Alasan Menolak Antrian',
      description: 'Masukkan alasan anda menolak antrian ini.',
      textNegativeButton: 'Batal',
      textPositiveButton: 'Kirim',
      controller: noteController,
      onTapNegativeButton: () => Get.back(),
      onTapPositiveButton: () {
        Get.back();
        rejectQueueChallenge();
      },
    );
    // DialogService.showDialogChoice(
    //   description: 'Apakah anda yakin ingin menolak antrian ini?',
    //   textNegativeButton: 'Tidak',
    //   textPositiveButton: 'Ya',
    //   onTapNegativeButton: () => Get.back(),
    //   onTapPositiveButton: () {
    //     Get.back();
    //     rejectQueueChallenge();
    //   },
    // );
  }

  Future<void> rejectQueueChallenge() async {
    DialogService.showLoading();

    var res = await _repository.approveOrRejectReservation(
      reservationId: item?.id ?? 0,
      status: 3,
      rejectReason: noteController.text,
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Menolak Antrian',
        description: res.message ?? 'Terjadi kesalahan saat menolak antrian.',
      );
      return;
    }

    await DialogService.showDialogSuccess(
      title: 'Berhasil Menolak Antrian',
      description: 'Antrian berhasil ditolak.',
    );

    Get.back();
  }
}
