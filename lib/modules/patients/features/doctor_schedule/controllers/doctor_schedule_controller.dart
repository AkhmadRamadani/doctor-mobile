import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_doctor_schedule_response.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/repositories/doctor_dashboard_repository.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_all_doctor_response.dart';
import 'package:get/get.dart';

class DoctorScheduleController extends GetxController {
  static DoctorScheduleController get to => Get.find();

  DoctorDashboardRepository repository = DoctorDashboardRepository();

  Rx<UIStateModel<List<ItemDoctorSchedule>>> scheduleState =
      const UIStateModel<List<ItemDoctorSchedule>>.idle().obs;

  ItemDoctor? selectedDoctor;

  Future<void> getDoctorSchedule() async {
    scheduleState.value =
        const UIStateModel<List<ItemDoctorSchedule>>.loading();

    GetDoctorScheduleResponse response = await repository.getDoctorSchedule(
      doctorId: selectedDoctor?.employeeId,
    );

    if (response.statusCode != 200) {
      scheduleState.value = UIStateModel<List<ItemDoctorSchedule>>.error(
        message: response.message ??
            'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
      return;
    }

    if ((response.data ?? []).isEmpty) {
      scheduleState.value = const UIStateModel<List<ItemDoctorSchedule>>.empty(
        message: 'Dokter belum mengatur jadwal praktek.',
      );

      return;
    }

    scheduleState.value = UIStateModel<List<ItemDoctorSchedule>>.success(
      data: response.data ?? [],
    );
  }

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      if (args is ItemDoctor) {
        selectedDoctor = args;
      }
    }
    getDoctorSchedule();
  }
}
