import 'package:auvnet/features/home/presentation/screens/widgets/service_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auvnet/features/home/presentation/bloc/home_bloc.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        if (state is HomeLoaded) {
          return SizedBox(
            height: 160.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: state.services.length,
              separatorBuilder: (_, _) => SizedBox(width: 26.w),
              itemBuilder: (context, index) {
                final service = state.services[index];
                return ServiceItem(
                  imagePath: service.imagePath,
                  badge: service.badge,
                  label: service.label,
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
