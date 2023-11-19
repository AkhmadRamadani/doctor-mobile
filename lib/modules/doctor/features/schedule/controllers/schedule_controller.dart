import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/models/responses/get_my_schedule_response.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/repositories/schedule_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ScheduleController extends GetxController {
  static ScheduleController get to => Get.find();

  Rx<UIStateModel<MetaMySchedule>> myScheduleState =
      const UIStateModel<MetaMySchedule>.idle().obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  ScheduleRepository repository = ScheduleRepository();

  DateTime currentDate = DateTime.now();

  void onRefresh({String? value}) async {
    await getMyScheduleChallenge();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getMyScheduleChallenge({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      refreshController.requestLoading();
    } else {
      myScheduleState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await repository.getDoctorSchedules(
      page: isLoadMore
          ? myScheduleState.value.whenOrNull(
                success: (data) => (data.currentPage ?? 0) + 1,
              ) ??
              1
          : 1,
      limit: 10,
      fromDate:
          currentDate.extToFormattedString(outputDateFormat: 'yyyy-MM-dd'),
    );

    if (isLoadMore) {
      if (res.statusCode != 200) {
        refreshController.loadFailed();
        return;
      }
      if ((res.meta?.data ?? []).isEmpty) {
        refreshController.loadNoData();
        return;
      }

      var prevData = myScheduleState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaMySchedule();

      myScheduleState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.meta?.data ?? []),
        currentPage: res.meta?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        myScheduleState.value = UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.meta?.data ?? []).isEmpty) {
        myScheduleState.value = const UIStateModel.empty();
        return;
      }

      myScheduleState.value = UIStateModel.success(
        data: res.meta ?? MetaMySchedule(),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMyScheduleChallenge();
  }
}
