import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:doctor_mobile/modules/patients/features/home/controllers/patients_home_controller.dart';
import 'package:doctor_mobile/modules/patients/shared/widgets/item_antrean_widget.dart';
import 'package:doctor_mobile/modules/patients/shared/widgets/menu_item_patients_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PatientsHomeView extends StatelessWidget {
  const PatientsHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientsHomeController());
    return SizedBox(
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
            onRefresh: controller.onRefresh,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: GetBuilder<PatientsHomeController>(
                            id: 'name',
                            builder: (state) {
                              return Text(
                                'Hi, ${state.user?.name ?? ""}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              );
                            }),
                      ),
                      subtitle: Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      style: ListTileStyle.drawer,
                      trailing: GestureDetector(
                        onTap: () {
                          Get.toNamed(PatientsRoutesConst.notification);
                        },
                        child: SizedBox(
                          width: 40.w,
                          height: 40.w,
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: 1.sw,
                      height: 0.45.sh,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          )
                        ],
                      ),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.listMenu.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.onTapMenu(index);
                            },
                            child: MenuItemPatientsWidget(
                              imagePath: controller.listMenu[index]['icon'],
                              title: controller.listMenu[index]['title'],
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(
                      () => controller.myReservationState.value.when(
                        success: (data) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                top: 16.h,
                                bottom: 8.h,
                              ),
                              child: Text(
                                "Antrean",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.sw,
                              height: 0.26.sh,
                              child: ListView.builder(
                                itemCount: data.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: index == 0 ? 16.w : 0,
                                      right: 16.w,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          PatientsRoutesConst.detailReservation,
                                          arguments: {
                                            'reservationId': data[index].id,
                                          },
                                        );
                                      },
                                      child: ItemAntreanWidget(
                                        queueNumber: data[index].nomorUrut,
                                        doctorName: data[index].doctorName,
                                        qualification: data[index].placeName,
                                        activeReservationNumber: data[index]
                                            .currentActiveReservation,
                                        remainingQueue:
                                            data[index].aheadReservation,
                                        status: data[index].status,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        empty: (message) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                top: 16.h,
                                bottom: 8.h,
                              ),
                              child: Text(
                                "Antrean",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.sw,
                              child: GeneralEmptyErrorWidget(
                                descText: message,
                                additionalWidgetBellowTextDesc: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      PatientsRoutesConst.makeAppointment,
                                    );
                                  },
                                  child: Container(
                                    width: 0.5.sw,
                                    height: 48,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 16.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorConst.primary500,
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Buat Reservasi',
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
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                          ],
                        ),
                        loading: () => Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 16.h,
                            bottom: 16.h,
                          ),
                          child: CustomShimmerWidget.buildShimmerWidget(
                            height: 0.21.sh,
                            width: 1.sw,
                            radius: 8,
                          ),
                        ),
                        error: (message) => GeneralEmptyErrorWidget(
                          descText: message,
                        ),
                        idle: () => const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
