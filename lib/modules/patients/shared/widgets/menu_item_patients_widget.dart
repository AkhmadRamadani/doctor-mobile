import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemPatientsWidget extends StatelessWidget {
  const MenuItemPatientsWidget({
    super.key,
    required this.imagePath,
    required this.title,
  });

  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEBFA),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Image.asset(
              imagePath,
              width: 100.w,
              height: 100.w,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorConst.primary900,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
