import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/controllers/detail_queue_controller.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/views/ui/components/status_pile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailQueueView extends StatelessWidget {
  const DetailQueueView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      DetailQueueController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Antrian'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 16,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                ),
                child: Text(
                  "Informasi Antrian",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorConst.primary900,
                  ),
                ),
              ),
              _DetailQueueCardWidget(
                title: 'Kode Reservasi',
                value: controller.item?.reservationCode ?? '-',
              ),
              _DetailQueueCardWidget(
                title: 'Nama Pasien',
                value: controller.item?.patientName ?? '-',
              ),
              _DetailQueueCardWidget(
                title: 'No. Antrian',
                value: controller.item?.nomorUrut.toString() ?? '-',
              ),
              _DetailQueueCardWidget(
                title: 'Status',
                child: StatusPileWidget(
                  width: 80,
                  status: controller.item?.status,
                ),
              ),
              _DetailQueueCardWidget(
                title: 'Tanggal',
                value:
                    (DateTime.tryParse(controller.item?.scheduleDate ?? '') ??
                            DateTime.now())
                        .toHumanReadableDateString(),
              ),
              _DetailQueueCardWidget(
                title: 'Tempat',
                value: controller.item?.placeName ?? '-',
              ),
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: ColorConst.complementary50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                ),
                child: Text(
                  "Informasi Pembayaran",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorConst.primary900,
                  ),
                ),
              ),
              _DetailQueueCardWidget(
                title: 'Pembayaran',
                value: controller.item?.paymentName ?? '-',
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (_) => controller.item?.bpjs == 1,
                widgetBuilder: (_) => Column(
                  children: [
                    _DetailQueueCardImageWidget(
                      title: 'Kartu BPJS',
                      url: controller.item?.bpjsCard ?? '',
                    ),
                    _DetailQueueCardImageWidget(
                      title: 'Kartu Identitas',
                      url: controller.item?.ktp ?? '',
                    ),
                    _DetailQueueCardImageWidget(
                      title: 'Surat Rujukan',
                      url: controller.item?.suratRujukan ?? '',
                    ),
                  ],
                ),
                fallbackBuilder: (_) => _DetailQueueCardImageWidget(
                  title: 'Bukti Pembayaran',
                  url: controller.item?.buktiPembayaran ?? '',
                ),
              ),
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: ColorConst.complementary50,
              ),
              SizedBox(
                height: 16.h,
              ),
              // Conditional.single(
              //   context: context,
              //   conditionBuilder: (_) => controller.item?.approve == 0,
              //   fallbackBuilder: (context) {
              //     return GestureDetector(
              //       onTap: () {
              //         controller.prosesQueue();
              //       },
              //       child: Container(
              //         width: 1.sw,
              //         height: 48,
              //         decoration: BoxDecoration(
              //           color: ColorConst.primary500,
              //           borderRadius: BorderRadius.circular(24.r),
              //         ),
              //         child: const Center(
              //           child: Text(
              //             'Proses',
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.w600,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              //   widgetBuilder: (_) => Conditional.single(
              //     context: context,
              //     conditionBuilder: (_) => controller.item?.status == 0,
              //     widgetBuilder: (_) => Row(
              //       children: [
              //         Expanded(
              //           child: GestureDetector(
              //             onTap: () {
              //               controller.approveQueue();
              //             },
              //             child: Container(
              //               width: 1.sw,
              //               height: 48,
              //               decoration: BoxDecoration(
              //                 color: ColorConst.primary500,
              //                 borderRadius: BorderRadius.circular(24.r),
              //               ),
              //               child: const Center(
              //                 child: Text(
              //                   'Terima',
              //                   style: TextStyle(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 16,
              //         ),
              //         Expanded(
              //           child: GestureDetector(
              //             onTap: () {
              //               controller.rejectQueue();
              //             },
              //             child: Container(
              //               width: 1.sw,
              //               height: 48,
              //               decoration: BoxDecoration(
              //                 color: Colors.redAccent,
              //                 borderRadius: BorderRadius.circular(24.r),
              //               ),
              //               child: const Center(
              //                 child: Text(
              //                   'Tolak',
              //                   style: TextStyle(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     fallbackBuilder: (_) => Container(),
              //   ),
              // ),
              Conditional.single(
                context: context,
                conditionBuilder: (_) => controller.item?.status == 0,
                widgetBuilder: (_) => Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.approveQueue();
                        },
                        child: Container(
                          width: 1.sw,
                          height: 48,
                          decoration: BoxDecoration(
                            color: ColorConst.primary500,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: const Center(
                            child: Text(
                              'Terima',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.rejectQueue();
                        },
                        child: Container(
                          width: 1.sw,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: const Center(
                            child: Text(
                              'Tolak',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                fallbackBuilder: (_) => Container(),
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (_) => controller.item?.status == 1,
                widgetBuilder: (_) => Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.finishQueue();
                        },
                        child: Container(
                          width: 1.sw,
                          height: 48,
                          decoration: BoxDecoration(
                            color: ColorConst.primary500,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: const Center(
                            child: Text(
                              'Selesai',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                fallbackBuilder: (_) => Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailQueueCardWidget extends StatelessWidget {
  const _DetailQueueCardWidget({
    this.title,
    this.value,
    this.child,
  });

  final String? title;
  final String? value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title ?? '-',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Conditional.single(
              context: context,
              conditionBuilder: (_) => child != null,
              widgetBuilder: (_) => child!,
              fallbackBuilder: (_) => Text(
                value ?? '-',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailQueueCardImageWidget extends StatelessWidget {
  const _DetailQueueCardImageWidget({
    this.title,
    this.url,
  });

  final String? title;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title ?? '-',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.dialog(
                  Dialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 1.sw,
                          child: InteractiveViewer(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.network(
                                url ?? '',
                                width: 1.sw,
                                height: 1.sh,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 1.sw,
                                  height: 1.sw,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorConst.analogous100,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 64.h,
                          right: 16.w,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    url ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 1.sw,
                      height: 1.sw,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorConst.analogous100,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
