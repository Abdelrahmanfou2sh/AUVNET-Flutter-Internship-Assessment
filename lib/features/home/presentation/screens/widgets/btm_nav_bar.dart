import 'package:auvnet/core/constants/app_assets.dart';
import 'package:auvnet/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': AppAssets.btm1, 'label': 'Home'},
      {'icon': AppAssets.btm2, 'label': 'Categories'},
      {'icon': AppAssets.btm3, 'label': 'Deliver'},
      {'icon': AppAssets.btm4, 'label': 'Cart'},
      {'icon': AppAssets.btm5, 'label': 'Profile'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  item['icon']!,
                  height: 24.h,
                  // color: isSelected ? AppColors.primaryColor : Colors.grey,
                ),
                SizedBox(height: 4.h),
                Text(
                  item['label']!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isSelected ? AppColors.primaryColor : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
