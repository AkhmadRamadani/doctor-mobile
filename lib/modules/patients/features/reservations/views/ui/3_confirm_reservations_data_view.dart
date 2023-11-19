import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/extensions/string_extensions.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/controllers/3_confirm_reservations_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfirmReservationsDataView extends StatelessWidget {
  const ConfirmReservationsDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmReservationsDataController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Konfirmasi Data',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorConst.primary900,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        (controller.doctor?.name ?? "").toAbbreviation(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
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
                    controller.doctor?.name ?? "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    controller.doctor?.qualification ?? "",
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
            Container(
              width: 1.sw,
              margin: EdgeInsets.symmetric(horizontal: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorConst.complementary50,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: ColorConst.complementary500,
                    size: 24.sp,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      'Harap untuk periksa dan verifikasi informasi berikut',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConst.complementary500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: 1.sw,
              margin: EdgeInsets.symmetric(horizontal: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 8.h,
                    ),
                    child: Text(
                      "Informasi Tempat",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConst.primary900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Tempat",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorConst.primary900,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          controller.doctorPlace?.name ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorConst.primary900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alamat",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorConst.primary900,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          controller.doctorPlace?.address ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorConst.primary900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1.h,
                    thickness: 1.h,
                    color: ColorConst.complementary50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Jadwal",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorConst.primary900,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "Tanggal",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorConst.primary900,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          (DateTime.tryParse(
                                      controller.doctorSchedule?.scheduleDate ??
                                          "") ??
                                  DateTime.now())
                              .toHumanReadableDateString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorConst.primary900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sisa Kuota",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorConst.primary900,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          controller.time ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorConst.primary900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.toPaymentMethod();
                    },
                    child: Container(
                      width: 1.sw,
                      height: 48,
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: ColorConst.primary500,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: const Center(
                        child: Text(
                          'Lanjutkan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
