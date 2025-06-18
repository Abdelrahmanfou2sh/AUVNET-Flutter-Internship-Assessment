import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class ServiceItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final String badge;

  const ServiceItem({
    super.key,
    required this.imagePath,
    required this.label,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // الإطار الخلفي
              Container(
                width: 115.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16.5.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.051),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: SizedBox(
                    width: 57.w,
                    height: 50.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.5.r),
                      child: CachedNetworkImage(
                        imageUrl: imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(badge, style: AppTextStyles.dmSansMedium12),
          ),

          SizedBox(height: 8.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.dmSansMedium14,
          ),
        ],
      ),
    );
  }
}
