import 'package:auvnet/core/theme/app_colors.dart';
import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShortcutItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const ShortcutItem({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      // width: 105.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 65.w,
            height: 65.h,
            decoration: BoxDecoration(
              color: const Color(0xffFFEEE6),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.051),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.contain,
                width: 32.w,
                height: 32.h,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.dmSansMedium12.copyWith(
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
