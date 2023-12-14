import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/controllers/patient_queue_controller.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/models/responses/get_all_reservations_response.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PatientQueueControllerWaiting extends PatientQueueController {
  static PatientQueueControllerWaiting get to => Get.find();

  PatientQueueControllerWaiting() {
    refreshController = RefreshController(initialRefresh: false);
    scrollController = ScrollController();
  }

  @override
  void onRefresh({String? value}) async {
    await getAllReservationsChallenge();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  Future<void> getAllReservationsChallenge({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      refreshController.requestLoading();
    } else {
      allReservationsState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await repository.getAllReservations(
      page: isLoadMore
          ? allReservationsState.value.whenOrNull(
                success: (data) => (data.currentPage ?? 0) + 1,
              ) ??
              1
          : 1,
      limit: 10,
      status: 0,
      approve: 0,
    );

    if (isLoadMore) {
      if (res.statusCode != 200) {
        refreshController.loadFailed();
        return;
      }
      if ((res.data?.data ?? []).isEmpty) {
        refreshController.loadNoData();
        return;
      }

      var prevData = allReservationsState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaAllReservations();

      allReservationsState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.data?.data ?? []),
        currentPage: res.data?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        allReservationsState.value =
            UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.data?.data ?? []).isEmpty) {
        allReservationsState.value = const UIStateModel.empty();
        return;
      }

      allReservationsState.value = UIStateModel.success(
        data: res.data ?? MetaAllReservations(),
      );
    }
  }
}
