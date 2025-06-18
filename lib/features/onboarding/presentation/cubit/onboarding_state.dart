/// States for the OnBoarding feature
sealed class OnBoardingState {}

/// Initial state when OnBoarding starts
class OnBoardingInitial extends OnBoardingState {}

/// State representing the current page in OnBoarding
class OnBoardingPageChanged extends OnBoardingState {
  final int currentPage;
  final int totalPages;

  OnBoardingPageChanged({
    required this.currentPage,
    required this.totalPages,
  });

  OnBoardingPageChanged copyWith({
    int? currentPage,
    int? totalPages,
  }) {
    return OnBoardingPageChanged(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

/// State when OnBoarding is completed
class OnBoardingCompleted extends OnBoardingState {}
