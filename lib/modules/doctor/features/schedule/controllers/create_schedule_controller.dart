import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/models/responses/get_my_schedule_response.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/repositories/schedule_repository.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_doctor_places_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/repositories/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateScheduleController extends GetxController {
  static CreateScheduleController get to => Get.find();

  ReservationRepository reservationRepository = ReservationRepository();
  ScheduleRepository repository = ScheduleRepository();

  TextEditingController placeNameTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController startTimeTextController = TextEditingController();
  TextEditingController endTimeTextController = TextEditingController();
  TextEditingController quotaTextController = TextEditingController();

  Rx<UIStateModel<List<ItemDoctorPlaces>>> getDoctorPlaceState =
      const UIStateModel<List<ItemDoctorPlaces>>.idle().obs;

  ItemDoctorPlaces? selectedPlace;
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  ItemMySchedule? itemMySchedule;

  RxBool isEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      if (args is ItemMySchedule) {
        itemMySchedule = args;
        _setInitialData();
      }
    }
  }

  void _setInitialData() {
    DateTime startDate = (DateTime.tryParse(
            "${itemMySchedule?.scheduleDate ?? ""} ${itemMySchedule?.scheduleTime ?? ""}") ??
        DateTime.now());

    DateTime endDate = (DateTime.tryParse(
            "${itemMySchedule?.scheduleDate ?? ""} ${itemMySchedule?.scheduleTimeEnd ?? ""}") ??
        DateTime.now());

    placeNameTextController.text = itemMySchedule?.placeName ?? '';
    dateTextController.text =
        (DateTime.tryParse(itemMySchedule?.scheduleDate ?? "") ??
                DateTime.now())
            .toHumanReadableDateString();
    startTimeTextController.text = startDate.toHHMMString();
    endTimeTextController.text = endDate.toHHMMString();
    quotaTextController.text = itemMySchedule?.qty?.toString() ?? '';
    selectedPlace = ItemDoctorPlaces(
      id: itemMySchedule?.id ?? 0,
      name: itemMySchedule?.placeName ?? '',
    );
    selectedDate =
        DateTime.tryParse(itemMySchedule?.scheduleDate ?? "") ?? DateTime.now();
    selectedStartTime = TimeOfDay(
      hour: startDate.hour,
      minute: startDate.minute,
    );
    selectedEndTime = TimeOfDay(
      hour: endDate.hour,
      minute: endDate.minute,
    );
    isEdit.value = true;
  }

  void selectDate(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      lastDate: DateTime.now().add(
        const Duration(days: 30),
      ),
    );

    if (date == null) {
      return;
    }

    selectedDate = date;
    dateTextController.text = date.toHumanReadableDateString();
  }

  void selectTimw(BuildContext context, bool isStartTime) async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) {
      return;
    }

    DateTime dateTime = DateTime(
      selectedDate?.year ?? DateTime.now().year,
      selectedDate?.month ?? DateTime.now().month,
      selectedDate?.day ?? DateTime.now().day,
      time.hour,
      time.minute,
    );

    if (isStartTime) {
      startTimeTextController.text = dateTime.toHHMMString();
      selectedStartTime = time;
    } else {
      endTimeTextController.text = dateTime.toHHMMString();
      selectedEndTime = time;
    }
  }

  void createSchedule() async {
    if (selectedPlace == null) {
      Get.snackbar(
        'Gagal',
        'Silahkan pilih tempat terlebih dahulu.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedDate == null) {
      Get.snackbar(
        'Gagal',
        'Silahkan pilih tanggal terlebih dahulu.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedStartTime == null) {
      Get.snackbar(
        'Gagal',
        'Silahkan pilih jam mulai terlebih dahulu.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedEndTime == null) {
      Get.snackbar(
        'Gagal',
        'Silahkan pilih jam selesai terlebih dahulu.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (quotaTextController.text.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Silahkan isi kuota terlebih dahulu.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (int.tryParse(quotaTextController.text) == null) {
      Get.snackbar(
        'Gagal',
        'Kuota harus berupa angka.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (int.tryParse(quotaTextController.text) == 0) {
      Get.snackbar(
        'Gagal',
        'Kuota tidak boleh 0.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (isEdit.value) {
      DialogService.showDialogChoice(
        title: 'Konfirmasi',
        description: 'Apakah anda yakin ingin mengubah jadwal?',
        onTapPositiveButton: () async {
          Get.back();
          await updateScheduleChallenge();
        },
        onTapNegativeButton: () {
          Get.back();
        },
      );
    } else {
      DialogService.showDialogChoice(
        title: 'Konfirmasi',
        description: 'Apakah anda yakin ingin membuat jadwal?',
        onTapPositiveButton: () async {
          Get.back();
          await createScheduleChallenge();
        },
        onTapNegativeButton: () {
          Get.back();
        },
      );
    }
  }

  Future<void> updateScheduleChallenge() async {
    DialogService.showLoading();

    var res = await repository.updateSchedule(
      id: itemMySchedule?.id ?? 0,
      placeId: selectedPlace?.id ?? 0,
      date: selectedDate.toString(),
      startTime: startTimeTextController.text,
      endTime: endTimeTextController.text,
      qty: int.parse(quotaTextController.text),
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Mengubah Jadwal',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Mengubah Jadwal',
        description: res.message ?? '',
        buttonOnTap: () {
          Get.close(2);
        },
      );
    }
  }

  Future<void> createScheduleChallenge() async {
    DialogService.showLoading();

    var res = await repository.createSchedule(
      placeId: selectedPlace?.id ?? 0,
      date: selectedDate.toString(),
      startTime: startTimeTextController.text,
      endTime: endTimeTextController.text,
      qty: int.parse(quotaTextController.text),
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Membuat Jadwal',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Membuat Jadwal',
        description: res.message ?? '',
        buttonOnTap: () {
          Get.close(2);
        },
      );
    }
  }

  void onGetDoctorPlace() async {
    getDoctorPlaceState.value = const UIStateModel.loading();
    var res = await reservationRepository.getDoctorPlace();

    if (res.statusCode != 200) {
      getDoctorPlaceState.value = UIStateModel.error(
        message: res.message ?? 'Terjadi kesalahan saat menerima data.',
      );
      return;
    }

    if ((res.data ?? []).isEmpty) {
      getDoctorPlaceState.value = const UIStateModel.empty(
        message: 'Tidak ada data lokasi.',
      );
      return;
    }

    getDoctorPlaceState.value = UIStateModel.success(
      data: res.data ?? [],
    );
  }

  void selectPlaces(BuildContext context) {
    onGetDoctorPlace();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _showPlaceNameModel();
      },
    );
  }

  Container _showPlaceNameModel() {
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
                    'Pilih Tempat',
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
            child: Obx(
              () =>
                  getDoctorPlaceState.value.whenOrNull(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (message) => SizedBox(
                      width: 1.sw,
                      child: Center(
                        child: GeneralEmptyErrorWidget(
                          descText: message,
                          customHeightContent: 0.3.sh,
                        ),
                      ),
                    ),
                    empty: (message) => SizedBox(
                      width: 1.sw,
                      child: Center(
                        child: GeneralEmptyErrorWidget(
                          descText: message,
                          customHeightContent: 0.3.sh,
                        ),
                      ),
                    ),
                    success: (data) => ListView.separated(
                      itemBuilder: (context, index) {
                        var item = data[index];
                        return GestureDetector(
                          onTap: () {
                            placeNameTextController.text = item.name ?? '';
                            selectedPlace = item;

                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 16.w,
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item.name ?? '',
                                style: Get.textTheme.bodyMedium,
                              ),
                              subtitle: Text(
                                item.address ?? '',
                                style: Get.textTheme.bodySmall,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                        );
                      },
                      itemCount: data.length,
                    ),
                  ) ??
                  const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  void deleteSchedule() {
    DialogService.showDialogChoice(
      title: 'Konfirmasi',
      description: 'Apakah anda yakin ingin menghapus jadwal?',
      onTapPositiveButton: () async {
        Get.back();
        await deleteScheduleChallenge();
      },
      onTapNegativeButton: () {
        Get.back();
      },
    );
  }

  Future<void> deleteScheduleChallenge() async {
    DialogService.showLoading();

    var res = await repository.deleteSchedule(
      id: itemMySchedule?.id ?? 0,
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Menghapus Jadwal',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Menghapus Jadwal',
        description: res.message ?? '',
        buttonOnTap: () {
          Get.close(2);
        },
      );
    }
  }
}
