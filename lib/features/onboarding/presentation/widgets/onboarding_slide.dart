import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auvnet/features/onboarding/data/onboarding_content.dart';
import 'package:auvnet/core/constants/app_assets.dart';

class OnBoardingSlide extends StatelessWidget {
  final OnBoardingContent content;

  const OnBoardingSlide({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.onBoarding),
        SizedBox(height: 48.h),
        Text(
          content.title,
          style: AppTextStyles.rubikMedium28,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          content.description,
          style: AppTextStyles.rubikRegular14,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
