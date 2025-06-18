import 'package:auvnet/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auvnet/core/services/shared_preferences_service.dart';

/// Cubit to manage OnBoarding state and navigation
class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  /// Current page index in the OnBoarding flow
  int _currentPage = 0;

  /// Total number of pages in the OnBoarding flow
  final int _totalPages = 3;

  /// Get the current page index
  int get currentPage => _currentPage;

  /// Handle page changes in the OnBoarding flow
  void onPageChanged(int page) {
    _currentPage = page;
    emit(OnBoardingPageChanged(
      currentPage: _currentPage,
      totalPages: _totalPages,
    ));
  }

  /// Navigate to the next page or complete OnBoarding
  Future<void> nextPage() async {
    if (_currentPage < _totalPages - 1) {
      _currentPage++;
      emit(OnBoardingPageChanged(
        currentPage: _currentPage,
        totalPages: _totalPages,
      ));
    } else {
      await completeOnBoarding();
    }
  }

  /// Complete the OnBoarding flow
  Future<void> completeOnBoarding() async {
    await SharedPrefrencesService.setOnboardingSeen();
    emit(OnBoardingCompleted());
  }
}