import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auvnet/features/home/presentation/bloc/home_bloc.dart';
import 'restaurant_item.dart';

class RestaurantsSection extends StatelessWidget {
  const RestaurantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Text(
                'Popular restaurants nearby:',
                style: AppTextStyles.dmSansBold16,
              ),
            ),
            if (state is HomeLoading)
              const Center(child: CircularProgressIndicator())
            else if (state is HomeError)
              Center(child: Text(state.message))
            else if (state is HomeLoaded)
              SizedBox(
                height: 180.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: state.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = state.restaurants[index];
                    return RestaurantItem(
                      image: restaurant.imageUrl,
                      name: restaurant.name,
                      time: restaurant.time,
                    );
                  },
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
