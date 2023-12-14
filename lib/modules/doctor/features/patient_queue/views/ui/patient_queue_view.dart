import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/doctor/constants/doctor_routes_const.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/controllers/patient_queue_controller.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/controllers/patient_queue_controller_done.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/controllers/patient_queue_controller_process.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/controllers/patient_queue_controller_rejected.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/controllers/patient_queue_controller_waiting.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/controllers/patient_queue_controller_waiting_confirmation.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/models/responses/get_all_reservations_response.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/views/ui/components/patient_queue_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PatientQueueView extends StatelessWidget {
  const PatientQueueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrian Pasien'),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: const TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Menunggu',
                  ),
                  Tab(
                    text: 'Proses',
                  ),
                  Tab(
                    text: 'Selesai',
                  ),
                  Tab(
                    text: 'Ditolak',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _Body(
                    controller: Get.put(
                      PatientQueueControllerWaiting(),
                      tag: 'waiting',
                    ),
                  ),
                  _Body(
                    controller: Get.put(
                      PatientQueueControllerProcess(),
                      tag: 'process',
                    ),
                  ),
                  _Body(
                    controller: Get.put(
                      PatientQueueControllerDone(),
                      tag: 'done',
                    ),
                  ),
                  _Body(
                    controller: Get.put(
                      PatientQueueControllerRejected(),
                      tag: 'rejected',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.controller,
  });

  final PatientQueueController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: SmartRefresher(
            controller: controller.refreshController,
            scrollController: controller.scrollController,
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: () => controller.onRefresh(),
            onLoading: () async {
              controller.getAllReservationsChallenge(
                isLoadMore: true,
              );
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Obx(
                () => controller.allReservationsState.value.when(
                  success: (data) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ItemAllReservations item = data.data![index];
                      return GestureDetector(
                        onTap: () async {
                          await Get.toNamed(
                            DoctorRoutesConst.patientQueueDetail,
                            arguments: item,
                          );
                          controller.getAllReservationsChallenge();
                        },
                        child: PatientQueueCardWidget(
                          noAntrian: item.nomorUrut ?? 0,
                          item: item,
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
        ),
      ],
    );
  }
}
