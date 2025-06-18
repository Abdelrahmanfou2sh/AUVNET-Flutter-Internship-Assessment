import 'package:auvnet/core/theme/app_colors.dart';
import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:auvnet/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../onboarding/domain/onboarding_data.dart';
import '../../../onboarding/presentation/widgets/onboarding_slide.dart';
import '../cubit/onboarding_cubit.dart';

class OnBoardingPager extends StatefulWidget {
  const OnBoardingPager({super.key});

  @override
  State<OnBoardingPager> createState() => _OnBoardingPagerState();
}

class _OnBoardingPagerState extends State<OnBoardingPager> {
  final PageController _controller = PageController();
  late final OnBoardingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = OnBoardingCubit();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _nextPage() {
    if (_cubit.currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _cubit.completeOnBoarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is OnBoardingCompleted) {
          context.go('/login');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) => _cubit.onPageChanged(index),
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    final content = onboardingData[index];
                    return OnBoardingSlide(content: content);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: _cubit.currentPage == index ? 12.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: _cubit.currentPage == index
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ElevatedButton(
                  onPressed: () async {
                    await _cubit.completeOnBoarding();
                  },
                  child: const Text('Get Started'),
                  // style: ElevatedButton.styleFrom(
                  //   textStyle: AppTextStyles.rubikMedium28,
                  // ),
                ),
              ),
              SizedBox(height: 12.h),
              InkWell(
                onTap: _nextPage,
                child: Text(
                  'next',
                  style: AppTextStyles.rubikRegular14.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }
}
