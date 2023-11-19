import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/models/response/get_my_medical_record_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailMedicalReportView extends StatefulWidget {
  const DetailMedicalReportView({super.key});

  @override
  State<DetailMedicalReportView> createState() =>
      _DetailMedicalReportViewState();
}

class _DetailMedicalReportViewState extends State<DetailMedicalReportView> {
  ItemMyMedicalRecord? data;

  @override
  void initState() {
    super.initState();
    var args = Get.arguments;
    if (args is ItemMyMedicalRecord) {
      data = args;
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Rekam Medis'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Konsultasi",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              data?.employeeName ?? '-',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              data?.employeeQualification ?? '-',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Tanggal",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              (DateTime.tryParse(data?.createdAt ?? '') ??
                                      DateTime.now())
                                  .toHumanReadableDateString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              (DateTime.tryParse(data?.createdAt ?? '') ??
                                      DateTime.now())
                                  .toHHMMString(),
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
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Keluhan",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    data?.complaint ?? '-',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Pemeriksaan Fisik",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    data?.physicalExam ?? '-',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Diagnosa",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    '${data?.icdCode ?? '-'} - ${data?.nameId ?? '-'}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Anjuran",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    data?.recommendation ?? '-',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Resep Obat",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    data?.recipe ?? '-',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
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
