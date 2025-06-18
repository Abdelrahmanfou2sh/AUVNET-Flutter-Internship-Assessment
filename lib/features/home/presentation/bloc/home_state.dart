part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeRefreshing extends HomeState {
  final List<Restaurant> restaurants;
  final List<Service> services;
  final List<Shortcut> shortcuts;

  const HomeRefreshing({
    required this.restaurants,
    required this.services,
    required this.shortcuts,
  });

  @override
  List<Object?> get props => [restaurants, services, shortcuts];
}

class HomeLoaded extends HomeState {
  final List<Restaurant> restaurants;
  final List<Service> services;
  final List<Shortcut> shortcuts;

  const HomeLoaded({
    required this.restaurants,
    required this.services,
    required this.shortcuts,
  });

  @override
  List<Object?> get props => [restaurants, services, shortcuts];

  HomeLoaded copyWith({
    List<Restaurant>? restaurants,
    List<Service>? services,
    List<Shortcut>? shortcuts,
  }) {
    return HomeLoaded(
      restaurants: restaurants ?? this.restaurants,
      services: services ?? this.services,
      shortcuts: shortcuts ?? this.shortcuts,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
