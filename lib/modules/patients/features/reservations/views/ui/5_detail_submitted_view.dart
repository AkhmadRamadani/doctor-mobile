import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/controllers/5_detail_submitted_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailSubmittedView extends StatelessWidget {
  const DetailSubmittedView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailSubmittedController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Reservasi'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Obx(
              () => controller.detailReservationState.value.when(
                success: (data) => Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConst.primary500,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            topRight: Radius.circular(8.r),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Detail Dokter",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              data.data?.doctorName ?? "",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Spesialis",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              data.data?.qualification ?? "",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                loading: () => CustomShimmerWidget.buildShimmerWidget(
                  width: 1.sw,
                  height: 200.h,
                ),
                error: (message) => GeneralEmptyErrorWidget(
                  descText: message,
                ),
                empty: (message) => GeneralEmptyErrorWidget(
                  descText: message,
                ),
                idle: () => CustomShimmerWidget.buildShimmerWidget(
                  width: 1.sw,
                  height: 200.h,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Obx(
              () => controller.detailReservationState.value.when(
                empty: (message) => GeneralEmptyErrorWidget(
                  descText: message,
                ),
                error: (message) => GeneralEmptyErrorWidget(
                  descText: message,
                ),
                idle: () => CustomShimmerWidget.buildShimmerWidget(
                  width: 1.sw,
                  height: 200.h,
                ),
                loading: () => CustomShimmerWidget.buildShimmerWidget(
                  width: 1.sw,
                  height: 200.h,
                ),
                success: (data) => Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConst.primary500,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            topRight: Radius.circular(8.r),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Detail Reservasi",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "No Antrian: ${data.data?.nomorUrut ?? ""}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              (DateTime.tryParse(
                                          data.data?.scheduleDate ?? "") ??
                                      DateTime.now())
                                  .toHumanReadableDateString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Jam",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "${(DateTime.tryParse("${data.data?.scheduleDate ?? ""} ${data.data?.scheduleTime ?? ""}") ?? DateTime.now()).toHHMMString()} - ${(DateTime.tryParse("${data.data?.scheduleDate ?? ""} ${data.data?.scheduleTimeEnd ?? ""}") ?? DateTime.now()).toHHMMString()}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Tempat",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              data.data?.placeName ?? "",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Sedang dilayani",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              data.data?.currentActiveReservation == null
                                  ? "Belum ada antrian"
                                  : 'Nomor ${data.data?.currentActiveReservation ?? 0}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Jumlah Antrian Sisa",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              data.data?.aheadReservation == null
                                  ? data.data?.nomorUrut ==
                                          data.data?.currentActiveReservation
                                      ? "Sekarang giliran anda"
                                      : data.data?.currentActiveReservation ==
                                              null
                                          ? "-"
                                          : "Berikutnya giliran Anda, mohon menunggu"
                                  : '${data.data?.aheadReservation ?? 0}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Kode Reservasi",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              '${data.data?.reservationCode ?? 0}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Obx(
              () =>
                  controller.detailReservationState.value.whenOrNull(
                    success: (data) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Terakhir Diperbarui",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "${controller.latestUpdate.toHumanReadableDateString()} ${controller.latestUpdate.toHHMMString()}",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              controller.getDetailReservation(
                                reservationId: controller.reservationId ?? 0,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConst.primary500,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                "Refresh",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) ??
                  Container(),
            )
          ],
        ),
      ),
    );
  }
}
