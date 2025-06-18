import 'package:auvnet/core/routing/go_router_refresh_wrapper.dart';
import 'package:auvnet/core/services/shared_preferences_service.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auvnet/features/home/presentation/bloc/home_bloc.dart';
import 'package:auvnet/features/home/presentation/screens/home_screen.dart';
import 'package:auvnet/features/onboarding/presentation/screens/onboarding_pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up.dart';
import '../di/service_locator.dart';

/// Application router configured using GoRouter
/// Handles onboarding visibility and user authentication routing
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) async {
          final hasSeen = await SharedPrefrencesService.hasSeenOnboarding();
          final user = FirebaseAuth.instance.currentUser;

          if (!hasSeen) return '/onboarding';
          if (user == null) return '/login';
          return '/home';
        },
      ),

      // Onboarding Screen
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnBoardingPager(),
      ),

      // Login Screen
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return BlocProvider<AuthBloc>.value(
            value: sl<AuthBloc>(),
            child: const LoginScreen(),
          );
        },
      ),

      // Signup Screen
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) {
          return BlocProvider<AuthBloc>.value(
            value: sl<AuthBloc>(),
            child: const SignUpScreen(),
          );
        },
      ),

      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          final homeBloc = sl<HomeBloc>()..add(const LoadHomeData());
          return BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: const HomeScreen(),
          );
        },
      ),
    ],

    /// Redirect logic to handle initial routing
    /// - If onboarding not seen → go to /onboarding
    /// - If user not logged in → go to /login
    /// - Else → stay on intended route (return null)
    redirect: (context, state) async {
      final hasSeen = await SharedPrefrencesService.hasSeenOnboarding();
      final user = FirebaseAuth.instance.currentUser;
      final isGoingToSignUp = state.uri.toString() == '/signup';
      final isGoingToLogin = state.uri.toString() == '/login';

      debugPrint(
        'Redirect: hasSeen=$hasSeen, user=$user, location=${state.uri}',
      );

      if (!hasSeen) return '/onboarding';
      if (user == null && !(isGoingToLogin || isGoingToSignUp)) return '/login';

      return null;
    },

    /// This allows the router to listen for auth state changes
    /// and refresh routing accordingly
    refreshListenable: GoRouterRefreshStreamWrapper(
      stream: FirebaseAuth.instance.authStateChanges(),
    ),
  );
}
