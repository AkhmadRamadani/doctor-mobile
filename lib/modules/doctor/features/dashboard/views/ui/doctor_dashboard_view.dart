import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/doctor/constants/doctor_routes_const.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/controllers/doctor_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DoctorHomeView extends StatelessWidget {
  const DoctorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorDashboardController());

    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: 1.sw,
                  height: 0.3.sh,
                  decoration: const BoxDecoration(
                    color: ColorConst.primary900,
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            SmartRefresher(
              controller: controller.refreshController,
              onRefresh: () => controller.onRefresh(),
              child: SingleChildScrollView(
                // padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () =>
                                  controller.nameState.value.whenOrNull(
                                    success: (data) => Text(
                                      'Hi, $data',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ) ??
                                  SizedBox(
                                    width: 170.w,
                                    child:
                                        CustomShimmerWidget.buildShimmerWidget(
                                      height: 16,
                                      radius: 8,
                                      baseColor: Colors.white,
                                      highlightColor: Colors.grey,
                                    ),
                                  ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Obx(
                              () =>
                                  controller.nameState.value.whenOrNull(
                                    success: (data) => Text(
                                      'Selamat Datang !',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ) ??
                                  SizedBox(
                                    width: 100.w,
                                    child:
                                        CustomShimmerWidget.buildShimmerWidget(
                                      height: 16,
                                      radius: 8,
                                      baseColor: Colors.white,
                                      highlightColor: Colors.grey,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          controller.selectedDate.toHumanReadableDateString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            Obx(
                              () =>
                                  controller.totalReservationsState.value
                                      .whenOrNull(
                                    success: (data) => Expanded(
                                      child: Container(
                                        width: 1.sw,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 8.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Total Antrian',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConst.primary900,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                              '${data.totalAll ?? 0}',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: ColorConst.primary900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    loading: () => Expanded(
                                      child: CustomShimmerWidget
                                          .buildShimmerWidget(
                                        height: 62,
                                        radius: 8,
                                        baseColor: Colors.white,
                                        highlightColor: Colors.grey,
                                      ),
                                    ),
                                  ) ??
                                  Expanded(
                                    child: Container(
                                      width: 1.sw,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 8.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Pasien Hari Ini',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConst.primary900,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            '0',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: ColorConst.primary900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Obx(
                              () =>
                                  controller.totalReservationsState.value
                                      .whenOrNull(
                                    success: (data) => Expanded(
                                      child: Container(
                                        width: 1.sw,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 8.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Menunggu Konfirmasi',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConst.primary900,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                              '${data.totalWaiting ?? 0}',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: ColorConst.primary900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    loading: () => Expanded(
                                      child: CustomShimmerWidget
                                          .buildShimmerWidget(
                                        height: 62,
                                        radius: 8,
                                        baseColor: Colors.white,
                                        highlightColor: Colors.grey,
                                      ),
                                    ),
                                  ) ??
                                  Expanded(
                                    child: Container(
                                      width: 1.sw,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 8.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Menunggu Konfirmasi',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConst.primary900,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            '0',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: ColorConst.primary900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Container(
                        width: 1.sw,
                        height: 0.32.sh,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.w,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: GridView(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                          ),
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(DoctorRoutesConst.patientQueue);
                              },
                              child: const _TileWidget(title: 'Antrian Pasien'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(DoctorRoutesConst.patientList);
                              },
                              child: const _TileWidget(title: 'Data Pasien'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    DoctorRoutesConst.doctorScheduleList);
                              },
                              child: const _TileWidget(title: 'Jadwal Praktek'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.announcement);
                              },
                              child: const _TileWidget(title: 'Pengumuman'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jadwal Yang Akan Datang",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorConst.primary900,
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Obx(
                              () =>
                                  controller.scheduleState.value.whenOrNull(
                                    empty: (message) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 16.h,
                                      ),
                                      child: SizedBox(
                                        width: 1.sw,
                                        child: GeneralEmptyErrorWidget(
                                          descText: message,
                                        ),
                                      ),
                                    ),
                                    success: (data) => Table(
                                      border: TableBorder.all(
                                        color: ColorConst.primary900,
                                        width: 1,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      children: [
                                        TableRow(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: ColorConst.primary900,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h,
                                              ),
                                              child: Text(
                                                'Hari',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: ColorConst.primary900,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h,
                                              ),
                                              child: Text(
                                                'Tempat',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: ColorConst.primary900,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h,
                                              ),
                                              child: Text(
                                                'Jadwal',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ...[
                                          for (int i = 0; i < data.length; i++)
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 8.h,
                                                  ),
                                                  child: Text(
                                                    (DateTime.tryParse(data[i]
                                                                    .scheduleDate ??
                                                                '') ??
                                                            DateTime.now())
                                                        .toHumanReadableDateString(),
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          ColorConst.primary900,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 8.h,
                                                  ),
                                                  child: Text(
                                                    data[i].placeName ?? '',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          ColorConst.primary900,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 8.h,
                                                  ),
                                                  child: Text(
                                                    '${data[i].scheduleTime ?? ''} - ${data[i].scheduleTimeEnd ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          ColorConst.primary900,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ],
                                    ),
                                  ) ??
                                  Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TileWidget extends StatelessWidget {
  const _TileWidget({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: ColorConst.primary900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
