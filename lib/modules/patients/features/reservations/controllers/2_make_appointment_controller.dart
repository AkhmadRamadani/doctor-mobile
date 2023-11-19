import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_doctor_schedule_response.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_all_doctor_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_doctor_places_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/repositories/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MakeAppointmentController extends GetxController {
  static MakeAppointmentController get to => Get.find();

  ReservationRepository repository = ReservationRepository();

  TextEditingController placeNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  ItemDoctorPlaces? place;
  ItemDoctorSchedule? schedule;
  ItemDoctor? doctor;
  User? user;

  int quota = 0;

  Rx<UIStateModel<List<ItemDoctorPlaces>>> getDoctorPlaceState =
      const UIStateModel<List<ItemDoctorPlaces>>.idle().obs;

  Rx<UIStateModel<List<ItemDoctorSchedule>>> getDoctorScheduleState =
      const UIStateModel<List<ItemDoctorSchedule>>.idle().obs;

  List<String> listTime = [];

  @override
  void onInit() {
    super.onInit();
    getUser();
    var args = Get.arguments;
    if (args != null) {
      if (args is ItemDoctor) {
        doctor = args;
      }
    }
  }

  Future<void> onGetRemainingQuota({
    required int scheduleId,
  }) async {
    var res = await repository.getRemainingQuota(
      scheduleId: scheduleId,
    );

    quota = res;
    update(['quota']);
  }

  void getUser() async {
    user = await repository.getCurrentUser();
    update();
  }

  void onGetDoctorPlace({
    int? doctorId,
  }) async {
    getDoctorPlaceState.value = const UIStateModel.loading();
    var res = await repository.getDoctorPlace(
      doctorId: doctorId,
    );

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

  void onGetDoctorScheduleByPlace({
    required int employeeId,
    required int placeId,
  }) async {
    getDoctorScheduleState.value = const UIStateModel.loading();
    var res = await repository.getDoctorScheduleByPlace(
      placeId: placeId,
      doctorId: employeeId,
    );

    if (res.statusCode != 200) {
      getDoctorScheduleState.value = UIStateModel.error(
        message: res.message ?? 'Terjadi kesalahan saat menerima data.',
      );
      return;
    }

    if ((res.data ?? []).isEmpty) {
      getDoctorScheduleState.value = const UIStateModel.empty(
        message: 'Tidak ada data jadwal.',
      );
      return;
    }

    getDoctorScheduleState.value = UIStateModel.success(
      data: res.data ?? [],
    );
  }

  void selectSchedule(BuildContext context) async {
    if (place == null) {
      Get.snackbar(
        'Error',
        'Pilih lokasi terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    onGetDoctorScheduleByPlace(
      placeId: place?.id ?? 0,
      employeeId: doctor?.employeeId ?? 0,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _showScheduleModal();
      },
    );
  }

  void selectTime(BuildContext context) async {
    if (schedule == null) {
      Get.snackbar(
        'Error',
        'Pilih jadwal terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _showTimeModal(context);
      },
    );
  }

  void selectPlaces(BuildContext context) {
    onGetDoctorPlace(
      doctorId: doctor?.employeeId,
    );
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _showPlacesModal();
      },
    );
  }

  void goToConfirmation() {
    if (place == null) {
      Get.snackbar(
        'Perhatian',
        'Pilih lokasi terlebih dahulu',
        backgroundColor: ColorConst.complementary500,
        colorText: Colors.white,
      );
      return;
    }

    if (schedule == null) {
      Get.snackbar(
        'Perhatian',
        'Pilih jadwal terlebih dahulu',
        backgroundColor: ColorConst.complementary500,
        colorText: Colors.white,
      );
      return;
    }

    if (quota == 0) {
      Get.snackbar(
        'Perhatian',
        'Kuota habis, silakan pilih jadwal lain.',
        backgroundColor: ColorConst.complementary500,
        colorText: Colors.white,
      );
      return;
    }

    Get.toNamed(
      PatientsRoutesConst.confirmReservationDetail,
      arguments: {
        'patient': user,
        'doctor': doctor,
        'place': place,
        'schedule': schedule,
        'time': quota.toString(),
      },
    );
  }

  Container _showPlacesModal() {
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
                    'Pilih Lokasi',
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
                            place = item;
                            placeNameController.text = item.name ?? '';
                            dateController.text = '';
                            timeController.text = '';

                            schedule = null;
                            listTime = [];

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

  Container _showScheduleModal() {
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
                    'Pilih Jadwal',
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
                  getDoctorScheduleState.value.whenOrNull(
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
                        DateTime scheduleDate = DateTime.tryParse(
                              (item.scheduleDate ?? ''),
                            ) ??
                            DateTime.now();
                        var startTime = DateTime.tryParse(
                              "${item.scheduleDate ?? ''} ${item.scheduleTime ?? ''}",
                            ) ??
                            DateTime.now();

                        var endTime = DateTime.tryParse(
                              "${item.scheduleDate ?? ''} ${item.scheduleTimeEnd ?? ''}",
                            ) ??
                            DateTime.now();

                        int quota = item.qty ?? 0;

                        return GestureDetector(
                          onTap: () async {
                            dateController.text =
                                scheduleDate.toHumanReadableDateString();

                            listTime = [];
                            // set duration based on quota
                            int diff = endTime.difference(startTime).inMinutes;

                            if (diff == 0) {
                              schedule = item;
                              Get.back();
                            }

                            int duration = diff ~/ quota;

                            for (var i = 0; i < quota; i++) {
                              var time = startTime.add(
                                Duration(
                                  minutes: duration * i,
                                ),
                              );
                              listTime.add(time.toHHMMString());
                            }

                            schedule = item;

                            await onGetRemainingQuota(
                              scheduleId: item.id ?? 0,
                            );

                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                scheduleDate.toHumanReadableDateString(),
                                style: Get.textTheme.bodyMedium,
                              ),
                              subtitle: Text(
                                '${startTime.toHHMMString()} - ${endTime.toHHMMString()}',
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

  Container _showTimeModal(BuildContext context) {
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
                    'Pilih Waktu',
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
            child: Conditional.single(
              context: context,
              conditionBuilder: (context) => listTime.isNotEmpty,
              widgetBuilder: (context) => ListView.separated(
                itemBuilder: (context, index) {
                  var item = listTime[index];
                  return GestureDetector(
                    onTap: () {
                      timeController.text = item;
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
                          item,
                          style: Get.textTheme.bodyMedium,
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
                itemCount: listTime.length,
              ),
              fallbackBuilder: (context) => SizedBox(
                width: 1.sw,
                child: Center(
                  child: GeneralEmptyErrorWidget(
                    descText:
                        'Tidak ada data waktu. Silakan pilih jadwal lain.',
                    customHeightContent: 0.3.sh,
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
