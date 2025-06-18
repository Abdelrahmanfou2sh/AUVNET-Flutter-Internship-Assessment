import 'package:auvnet/core/constants/app_assets.dart';
import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GotACodeSection extends StatelessWidget {
  const GotACodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        width: 343.w,
        height: 89.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.051),
              offset: Offset(0, 4.h),
              blurRadius: 16.r,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 78.9.h,
              width: 80.h,
              child: Image.asset(AppAssets.gotACode),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Got a code!', style: AppTextStyles.dmSansBold14),
                  SizedBox(height: 4.h),
                  Text(
                    'Add your code and save on your\n order',
                    style: AppTextStyles.dmSansMedium10,
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
