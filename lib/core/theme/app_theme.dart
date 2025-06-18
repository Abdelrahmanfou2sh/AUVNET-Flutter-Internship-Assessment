import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.rubikBold30,
      displayMedium: AppTextStyles.rubikBold20,
      headlineMedium: AppTextStyles.rubikMedium28,
      titleLarge: AppTextStyles.rubikMedium18,
      titleMedium: AppTextStyles.dmSansBold16,
      titleSmall: AppTextStyles.dmSansBold14,
      bodyLarge: AppTextStyles.dmSansMedium14,
      bodyMedium: AppTextStyles.rubikRegular14,
      bodySmall: AppTextStyles.dmSansMedium12,
      labelLarge: AppTextStyles.poppinsRegular12,
      labelMedium: AppTextStyles.mulishLight14,
      labelSmall: AppTextStyles.dmSansMedium10,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        textStyle: AppTextStyles.dmSansMedium14,
        minimumSize: Size(343.w, 50.h),
      ),
    ),
  );
}
