import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_doctor_schedule_response.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_today_reservations_total_response.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/repositories/doctor_dashboard_repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DoctorDashboardController extends GetxController {
  static DoctorDashboardController get to => Get.find();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Rx<UIStateModel<String>> nameState = const UIStateModel<String>.idle().obs;
  Rx<UIStateModel<DataTotalReservations>> totalReservationsState =
      const UIStateModel<DataTotalReservations>.idle().obs;
  Rx<UIStateModel<List<ItemDoctorSchedule>>> scheduleState =
      const UIStateModel<List<ItemDoctorSchedule>>.idle().obs;

  DoctorDashboardRepository repository = DoctorDashboardRepository();

  DateTime selectedDate = DateTime.now();

  void onRefresh({String? value}) async {
    Future.wait([
      getName(),
      getTodayTotalReservations(),
      getDoctorSchedule(),
    ]);
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getName() async {
    nameState.value = const UIStateModel<String>.loading();

    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    String name = await repository.getCurrentUserName();

    nameState.value = UIStateModel<String>.success(data: name);
  }

  Future<void> getTodayTotalReservations() async {
    totalReservationsState.value =
        const UIStateModel<DataTotalReservations>.loading();

    GetTodayReservationsTotalResponse response =
        await repository.getTodayTotalReservations();

    if (response.statusCode != 200) {
      totalReservationsState.value = UIStateModel<DataTotalReservations>.error(
        message: response.message ??
            'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }

    totalReservationsState.value = UIStateModel<DataTotalReservations>.success(
      data: response.data ?? DataTotalReservations(),
    );
  }

  Future<void> getDoctorSchedule() async {
    scheduleState.value =
        const UIStateModel<List<ItemDoctorSchedule>>.loading();

    GetDoctorScheduleResponse response = await repository.getDoctorSchedule();

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
    getName();
    getTodayTotalReservations();
    getDoctorSchedule();
  }
}
