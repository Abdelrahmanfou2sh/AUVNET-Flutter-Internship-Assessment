import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auvnet/features/home/domain/entities/restaurant.dart';
import 'package:auvnet/features/home/domain/entities/service.dart';
import 'package:auvnet/features/home/domain/entities/shortcut.dart';
import 'package:auvnet/features/home/domain/usecases/get_restaurants_usecase.dart';
import 'package:auvnet/features/home/domain/usecases/get_services_usecase.dart';
import 'package:auvnet/features/home/domain/usecases/get_shortcuts_usecase.dart';
import 'package:flutter/foundation.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRestaurantsUseCase getRestaurants;
  final GetServicesUseCase getServices;
  final GetShortcutsUseCase getShortcuts;

  HomeBloc({
    required this.getRestaurants,
    required this.getServices,
    required this.getShortcuts,
  }) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event,
      Emitter<HomeState> emit,
      ) async {
    if (state is! HomeLoading) {
      emit(HomeLoading());
      debugPrint('🔄 Fetching home data...');

      final restaurantsResult = await getRestaurants();
      final servicesResult = await getServices();
      final shortcutsResult = await getShortcuts();

      debugPrint('📦 Got restaurantsResult: $restaurantsResult');
      debugPrint('📦 Got servicesResult: $servicesResult');
      debugPrint('📦 Got shortcutsResult: $shortcutsResult');

      if (restaurantsResult.isLeft() ||
          servicesResult.isLeft() ||
          shortcutsResult.isLeft()) {
        debugPrint('❌ One of the requests failed!');
        emit(const HomeError(message: 'Failed to load home data'));
        return;
      }

      final restaurants = restaurantsResult.getOrElse(() => []);
      final services = servicesResult.getOrElse(() => []);
      final shortcuts = shortcutsResult.getOrElse(() => []);

      debugPrint('✅ Loaded restaurants: $restaurants');
      debugPrint('✅ Loaded services: $services');
      debugPrint('✅ Loaded shortcuts: $shortcuts');

      emit(
        HomeLoaded(
          restaurants: restaurants,
          services: services,
          shortcuts: shortcuts,
        ),
      );
    }
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(
        HomeRefreshing(
          restaurants: currentState.restaurants,
          services: currentState.services,
          shortcuts: currentState.shortcuts,
        ),
      );

      final restaurantsResult = await getRestaurants();
      final servicesResult = await getServices();
      final shortcutsResult = await getShortcuts();

      // Check if any of the results failed
      if (restaurantsResult.isLeft() ||
          servicesResult.isLeft() ||
          shortcutsResult.isLeft()) {
        emit(const HomeError(message: 'Failed to refresh home data'));
        return;
      }

      // Extract the successful results
      final restaurants = restaurantsResult.getOrElse(() => []);
      final services = servicesResult.getOrElse(() => []);
      final shortcuts = shortcutsResult.getOrElse(() => []);

      emit(
        HomeLoaded(
          restaurants: restaurants,
          services: services,
          shortcuts: shortcuts,
        ),
      );
    }
  }
}
