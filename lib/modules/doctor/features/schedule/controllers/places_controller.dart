import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/models/responses/get_my_places_response.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/repositories/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PlaceController extends GetxController {
  static PlaceController get to => Get.find();

  Rx<UIStateModel<MetaMyPlaces>> allIcdsState =
      const UIStateModel<MetaMyPlaces>.idle().obs;

  final PlaceRepository _repository = PlaceRepository();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  void onRefresh({String? value}) async {
    await getMyPlacesChallenge(
      search: value,
    );
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getMyPlacesChallenge({
    bool isLoadMore = false,
    String? search,
  }) async {
    if (isLoadMore) {
      refreshController.requestLoading();
    } else {
      allIcdsState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await _repository.getMyPlaces(
      page: isLoadMore
          ? allIcdsState.value.whenOrNull(
                success: (data) => (data.currentPage ?? 0) + 1,
              ) ??
              1
          : 1,
      limit: 20,
      search: search,
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

      var prevData = allIcdsState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaMyPlaces();

      allIcdsState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.meta?.data ?? []),
        currentPage: res.meta?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        allIcdsState.value = UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.meta?.data ?? []).isEmpty) {
        allIcdsState.value = const UIStateModel.empty();
        return;
      }

      allIcdsState.value = UIStateModel.success(
        data: res.meta ?? MetaMyPlaces(),
      );
    }
  }

  void onSelectIcds(ItemPlace? icds) {
    Get.back(result: icds);
  }

  @override
  void onInit() async {
    super.onInit();
    await getMyPlacesChallenge();
  }
}
