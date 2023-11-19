import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/doctor/constants/doctor_routes_const.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/controllers/schedule_controller.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/models/responses/get_my_schedule_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ScheduleController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(
            DoctorRoutesConst.doctorScheduleCreate,
          );
          controller.getMyScheduleChallenge();
        },
        backgroundColor: ColorConst.primary900,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        scrollController: controller.scrollController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: () => controller.onRefresh(),
        onLoading: () async {
          controller.getMyScheduleChallenge(
            isLoadMore: true,
          );
        },
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Obx(
            () => controller.myScheduleState.value.when(
              success: (data) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await Get.toNamed(
                        DoctorRoutesConst.doctorScheduleCreate,
                        arguments: data.data?[index],
                      );
                      controller.getMyScheduleChallenge();
                    },
                    child: _ScheduleCardWidget(
                      item: data.data?[index],
                    ),
                  );
                },
                itemCount: data.data?.length ?? 0,
              ),
              empty: (message) => SizedBox(
                height: 0.5.sh,
                child: Center(
                  child: GeneralEmptyErrorWidget(
                    descText: message,
                  ),
                ),
              ),
              loading: () => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: CustomShimmerWidget().list(
                  length: 10,
                ),
              ),
              error: (message) => SizedBox(
                height: 0.5.sh,
                child: Center(
                  child: GeneralEmptyErrorWidget(
                    descText: message,
                  ),
                ),
              ),
              idle: () => const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScheduleCardWidget extends StatelessWidget {
  const _ScheduleCardWidget({
    this.item,
  });

  final ItemMySchedule? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorConst.primary100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.schedule_rounded,
                  color: ColorConst.primary900,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.placeName ?? '-',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      (DateTime.tryParse(item?.scheduleDate ?? "") ??
                              DateTime.now())
                          .toHumanReadableDateString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${(DateTime.tryParse("${item?.scheduleDate ?? ""} ${item?.scheduleTime ?? ""}") ?? DateTime.now()).toHHMMString()} - ${(DateTime.tryParse("${item?.scheduleDate ?? ""} ${item?.scheduleTimeEnd ?? ""}") ?? DateTime.now()).toHHMMString()}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorConst.primary100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.edit,
                  color: ColorConst.primary900,
                ),
              ),
            ],
          ),
          if (item?.isExpired ?? false)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 1.sw,
                height: 1.sh,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
