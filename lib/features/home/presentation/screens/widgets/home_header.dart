import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:auvnet/core/theme/app_colors.dart';
import 'package:auvnet/core/constants/app_assets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(31.w, 35.h, 30.w, 37.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, const Color(0xFFFFDE59)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivering to',
                  style: AppTextStyles.dmSansBold12,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Al Satwa, 81A Street',
                  style: AppTextStyles.dmSansBold16,
                ),
                SizedBox(height: 7.h),
                Text(
                  'Hi hepa!',
                  style: AppTextStyles.rubikBold30,
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 28.r,
            backgroundImage: AssetImage(AppAssets.profile),
          ),
        ],
      ),
    );
  }
}
