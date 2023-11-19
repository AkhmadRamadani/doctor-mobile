import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/extensions/string_extensions.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/patients/features/doctor_schedule/controllers/doctor_schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DoctorScheduleView extends StatelessWidget {
  const DoctorScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorScheduleController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Dokter',
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw,
              height: 0.28.sh,
              decoration: BoxDecoration(
                color: ColorConst.primary900,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    width: 100.w,
                    height: 100.w,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        (controller.selectedDoctor?.name ?? '')
                            .toAbbreviation(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConst.primary900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'dr. ${controller.selectedDoctor?.name ?? ''}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    controller.selectedDoctor?.qualification ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Obx(
                () =>
                    controller.scheduleState.value.whenOrNull(
                      loading: () => CustomShimmerWidget.buildShimmerWidget(
                        height: 0.3.sh,
                        width: 1.sw,
                        radius: 16.r,
                      ),
                      empty: (message) => SizedBox(
                        width: 1.sw,
                        child: GeneralEmptyErrorWidget(
                          descText: message,
                        ),
                      ),
                      error: (message) => SizedBox(
                        width: 1.sw,
                        child: GeneralEmptyErrorWidget(
                          descText: message,
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
                                      (DateTime.tryParse(
                                                  data[i].scheduleDate ?? '') ??
                                              DateTime.now())
                                          .toHumanReadableDateString(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConst.primary900,
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
                                        fontWeight: FontWeight.w400,
                                        color: ColorConst.primary900,
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
                                        fontWeight: FontWeight.w400,
                                        color: ColorConst.primary900,
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
            ),
          ],
        ),
      ),
    );
  }
}
