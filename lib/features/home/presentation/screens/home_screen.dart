import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:auvnet/features/home/presentation/screens/widgets/banner_slider.dart';
import 'package:auvnet/features/home/presentation/screens/widgets/btm_nav_bar.dart';
import 'package:auvnet/features/home/presentation/screens/widgets/got_a_code_section.dart';
import 'package:auvnet/features/home/presentation/screens/widgets/home_header.dart';
import 'package:auvnet/features/home/presentation/screens/widgets/restaurant_section.dart';
import 'package:auvnet/features/home/presentation/screens/widgets/services_section.dart';
import 'package:auvnet/features/home/presentation/screens/widgets/shortcut_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {
          // todo: Implement navigation logic
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text('Services:', style: AppTextStyles.dmSansBold20),
            ),
            SizedBox(height: 19.h),
            const ServicesSection(),
            SizedBox(height: 24.h),
            const GotACodeSection(),
            SizedBox(height: 14.h),
            const ShortcutsSection(),
            SizedBox(height: 48.h),
            const BannerSlider(),
            SizedBox(height: 34.h),
            const RestaurantsSection(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
