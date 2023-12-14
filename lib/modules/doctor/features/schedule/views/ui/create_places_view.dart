import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/widget/custom_input_text_widget.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/controllers/create_place_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreatePlaceView extends StatelessWidget {
  const CreatePlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CreatePlaceController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.isEdit.value
              ? const Text('Edit Tempat')
              : const Text('Tambah Tempat'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomInputTextWidget(
                controller: controller.nameController,
                title: 'Nama Tempat',
                hintText: 'Nama Tempat',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                prefixIcon: Icons.location_on_outlined,
              ),
              CustomInputTextWidget(
                controller: controller.addressController,
                title: 'Alamat',
                hintText: 'Alamat',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                prefixIcon: Icons.calendar_today_outlined,
              ),
              SizedBox(
                height: 16.w,
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (_) => controller.isEdit.value,
                widgetBuilder: (_) => GestureDetector(
                  onTap: () {
                    controller.deletePlace();
                  },
                  child: Container(
                    width: 1.sw,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: const Center(
                      child: Text(
                        'Hapus',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                fallbackBuilder: (_) => const SizedBox(),
              ),
              SizedBox(
                height: 16.w,
              ),
              GestureDetector(
                onTap: () {
                  controller.createPlace();
                },
                child: Container(
                  width: 1.sw,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ColorConst.primary900,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Center(
                    child: Text(
                      'Simpan',
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
