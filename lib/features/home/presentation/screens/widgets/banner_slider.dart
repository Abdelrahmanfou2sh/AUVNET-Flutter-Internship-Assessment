import 'package:auvnet/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              AppAssets.banner,
              width: double.infinity,
              height: 140.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(7, (index) {
            final isActive = index == 0;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: isActive ? 12.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: isActive ? Colors.purple : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.r),
              ),
            );
          }),
        ),
      ],
    );
  }
}
