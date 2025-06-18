import 'package:auvnet/core/theme/app_colors.dart';
import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantItem extends StatelessWidget {
  final String image;
  final String name;
  final String time;

  const RestaurantItem({
    super.key,
    required this.image,
    required this.name,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      // margin: EdgeInsets.only(right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            padding: EdgeInsets.all(8.w),
            child: CachedNetworkImage(imageUrl: image),
          ),
          SizedBox(height: 8.h),
          Text(
            name,
            style: AppTextStyles.dmSansMedium12.copyWith(
              color: AppColors.blackColor,
            ),
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, size: 14.sp, color: AppColors.greyColor),
              SizedBox(width: 4.w),
              Text(time, style: AppTextStyles.dmSansMedium10),
            ],
          ),
        ],
      ),
    );
  }
}
