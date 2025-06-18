import 'package:auvnet/core/di/service_locator.dart';
import 'package:auvnet/core/init/app_init.dart';
import 'package:auvnet/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/presentation/bloc/home_bloc.dart';

/// Entry point of the application.
/// Initializes necessary configurations and runs the app.
void main() async {
  await AppInit.init();
  runApp(const MyApp());
}

/// Root widget of the application.
/// Configures global providers, screen utilities, and theme settings.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            title: 'Nawel',
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
