import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/doctor/constants/doctor_routes_const.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/controllers/places_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SelectPlaceView extends StatelessWidget {
  const SelectPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlaceController controller = Get.put(
      PlaceController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Tempat'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(
            DoctorRoutesConst.doctorPlaceCreate,
          );
          controller.getMyPlacesChallenge();
        },
        backgroundColor: ColorConst.primary900,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Cari Tempat',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    controller.searchController.clear();
                    controller.getMyPlacesChallenge();
                  },
                  child: const Icon(
                    Icons.clear,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (value) {
                controller.getMyPlacesChallenge(
                  search: value,
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: SmartRefresher(
              controller: controller.refreshController,
              scrollController: controller.scrollController,
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: () => controller.onRefresh(
                value: controller.searchController.text,
              ),
              onLoading: () async {
                controller.getMyPlacesChallenge(
                  isLoadMore: true,
                  search: controller.searchController.text,
                );
              },
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Obx(
                  () => controller.allIcdsState.value.when(
                    success: (data) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.onSelectIcds(
                              data.data?[index],
                            );
                          },
                          child: ListTile(
                            title: Text(
                              data.data?[index].name ?? '',
                            ),
                            subtitle: Text(
                              data.data?[index].address ?? '',
                            ),
                            trailing: SizedBox(
                              width: 70.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await Get.toNamed(
                                        DoctorRoutesConst.doctorPlaceCreate,
                                        arguments: data.data?[index],
                                      );
                                      controller.getMyPlacesChallenge();
                                    },
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Icon(
                                    Icons.add,
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
