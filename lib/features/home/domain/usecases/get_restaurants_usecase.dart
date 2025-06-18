import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:auvnet/core/error/failures.dart';
import 'package:auvnet/features/home/domain/entities/restaurant.dart';
import 'package:auvnet/features/home/domain/repositories/home_repository.dart';

class GetRestaurantsUseCase {
  final HomeRepository repository;

  GetRestaurantsUseCase(this.repository);

  Future<Either<Failure, List<Restaurant>>> call() async {
    try {
      debugPrint('🟡 Trying to get cached restaurants...');
      final cachedResult = await repository.getCachedRestaurants();

      final hasCachedData = cachedResult.fold(
        (failure) => false,
        (list) => list.isNotEmpty,
      );

      if (hasCachedData) {
        debugPrint('✅ Loaded restaurants from cache.');
        return cachedResult;
      }

      debugPrint('📡 No cache. Fetching from Firestore...');
      final remoteResult = await repository.getRestaurants();

      remoteResult.fold(
        (failure) => debugPrint('❌ Failed to fetch from remote: $failure'),
        (restaurants) async {
          debugPrint('✅ Fetched from Firestore. Caching...');
          await repository.cacheRestaurants(restaurants);
        },
      );

      return remoteResult;
    } catch (e) {
      debugPrint('❌ Unexpected error in usecase: $e');
      return Left(ServerFailure(message: e.toString(), code: 'USECASE_ERROR'));
    }
  }
}
