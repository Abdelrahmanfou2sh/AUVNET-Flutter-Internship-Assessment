import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:auvnet/features/home/presentation/bloc/home_bloc.dart';
import '../widgets/shortcut_item.dart';

class ShortcutsSection extends StatelessWidget {
  const ShortcutsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shortcuts', style: AppTextStyles.dmSansBold20),
              SizedBox(height: 12.h),
              if (state is HomeLoading)
                const Center(child: CircularProgressIndicator())
              else if (state is HomeError)
                Center(child: Text(state.message))
              else if (state is HomeLoaded)
                SizedBox(
                  height: 110.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.shortcuts.length,
                    separatorBuilder: (_, __) => SizedBox(width: 8.w),
                    itemBuilder: (context, index) {
                      final shortcut = state.shortcuts[index];
                      return ShortcutItem(
                        imagePath: shortcut.imagePath,
                        label: shortcut.label,
                      );
                    },
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
