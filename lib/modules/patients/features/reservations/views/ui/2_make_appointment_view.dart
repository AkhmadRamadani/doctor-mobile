import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/string_extensions.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/controllers/2_make_appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MakeAppointmentView extends StatelessWidget {
  const MakeAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MakeAppointmentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Janji Temu',
        ),
        backgroundColor: ColorConst.primary900,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
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
                          (controller.doctor?.name ?? '').toAbbreviation(),
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
                      controller.doctor?.name ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      controller.doctor?.qualification ?? '',
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
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pilih Lokasi",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConst.primary900,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormField(
                      controller: controller.placeNameController,
                      readOnly: true,
                      onTap: () {
                        controller.selectPlaces(context);
                      },
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorConst.primary900,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        hintText: 'Pilih Tempat Praktik',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: ColorConst.primary500,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: ColorConst.primary500,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: ColorConst.primary500,
                        ),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: ColorConst.primary500,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tentukan Tanggal",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConst.primary900,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormField(
                      controller: controller.dateController,
                      readOnly: true,
                      onTap: () {
                        controller.selectSchedule(context);
                      },
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorConst.primary900,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        hintText: 'Pilih Tanggal',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: ColorConst.primary500,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: ColorConst.primary500,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: ColorConst.primary500,
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: ColorConst.primary500,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              GetBuilder<MakeAppointmentController>(
                id: 'quota',
                builder: (state) {
                  return Conditional.single(
                    context: context,
                    conditionBuilder: (_) => state.schedule != null,
                    fallbackBuilder: (_) => const SizedBox(),
                    widgetBuilder: (_) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sisa Kuota",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorConst.primary900,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: 1.sw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.h, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: ColorConst.primary50,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: ColorConst.primary900,
                                  size: 16.sp,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Expanded(
                                  child: Text(
                                    'Sisa kuota untuk tanggal ${controller.schedule?.scheduleDate ?? ""} adalah ${state.quota}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConst.primary900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              // SizedBox(
              //   height: 16.h,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.w),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Tentukan Waktu Kunjungan",
              //         style: TextStyle(
              //           fontSize: 16.sp,
              //           fontWeight: FontWeight.w600,
              //           color: ColorConst.primary900,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 8.h,
              //       ),
              //       TextFormField(
              //         controller: controller.timeController,
              //         readOnly: true,
              //         onTap: () {
              //           controller.selectTime(context);
              //         },
              //         style: TextStyle(
              //           fontSize: 12.sp,
              //           fontWeight: FontWeight.w400,
              //           color: ColorConst.primary900,
              //         ),
              //         decoration: const InputDecoration(
              //           contentPadding: EdgeInsets.symmetric(
              //             horizontal: 16,
              //             vertical: 16,
              //           ),
              //           hintText: 'Pilih Waktu Kunjungan',
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(8),
              //             ),
              //             borderSide: BorderSide(
              //               color: ColorConst.primary500,
              //             ),
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(8),
              //             ),
              //             borderSide: BorderSide(
              //               color: ColorConst.primary500,
              //             ),
              //           ),
              //           suffixIcon: Icon(
              //             Icons.arrow_drop_down_rounded,
              //             color: ColorConst.primary500,
              //           ),
              //           prefixIcon: Icon(
              //             Icons.access_time_outlined,
              //             color: ColorConst.primary500,
              //           ),
              //         ),
              //         textInputAction: TextInputAction.next,
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 32.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.goToConfirmation();
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
      ),
    );
  }
}
