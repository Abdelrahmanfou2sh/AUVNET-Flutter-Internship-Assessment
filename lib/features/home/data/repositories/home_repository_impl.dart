import 'package:auvnet/features/home/data/models/restaurant_model.dart';
import 'package:auvnet/features/home/data/models/service_model.dart';
import 'package:auvnet/features/home/data/models/shortcut_model.dart';
import 'package:dartz/dartz.dart';

import 'package:auvnet/core/error/failures.dart';
import 'package:auvnet/features/home/data/datasources/home_local_datasource.dart';
import 'package:auvnet/features/home/data/datasources/home_remote_datasource.dart';
import 'package:auvnet/features/home/domain/entities/restaurant.dart';
import 'package:auvnet/features/home/domain/entities/service.dart';
import 'package:auvnet/features/home/domain/entities/shortcut.dart';
import 'package:auvnet/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  // Future<Either<Failure, List<Restaurant>>> getRestaurants() async {
  //   try {
  //     final restaurants = await remoteDataSource.getRestaurants();
  //     await localDataSource.cacheRestaurants(restaurants);
  //     return Right(restaurants.map((model) => model.toEntity()).toList());
  //   } catch (e) {
  //     return Left(ServerFailure(message: e.toString(), code: 'SERVER_ERROR'));
  //   }
  // }
  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurants() async {
    try {
      debugPrint('🟡 HomeRepositoryImpl.getRestaurants STARTED');
      final restaurants = await remoteDataSource.getRestaurants();
      debugPrint(
        '🟢 HomeRepositoryImpl.getRestaurants GOT: ${restaurants.length}',
      );
      await localDataSource.cacheRestaurants(restaurants);
      return Right(restaurants.map((model) => model.toEntity()).toList());
    } catch (e) {
      debugPrint('🔴 HomeRepositoryImpl.getRestaurants ERROR: $e');
      return Left(ServerFailure(message: e.toString(), code: 'SERVER_ERROR'));
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getServices() async {
    try {
      final services = await remoteDataSource.getServices();
      await localDataSource.cacheServices(services);
      return Right(services.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), code: 'SERVER_ERROR'));
    }
  }

  @override
  Future<Either<Failure, List<Shortcut>>> getShortcuts() async {
    try {
      final shortcuts = await remoteDataSource.getShortcuts();
      await localDataSource.cacheShortcuts(shortcuts);
      return Right(shortcuts.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), code: 'SERVER_ERROR'));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getCachedRestaurants() async {
    try {
      final restaurants = await localDataSource.getCachedRestaurants();
      return Right(restaurants.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to retrieve cached restaurants',
          code: 'CACHE_ERROR',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getCachedServices() async {
    try {
      final services = await localDataSource.getCachedServices();
      return Right(services.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to retrieve cached services',
          code: 'CACHE_ERROR',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Shortcut>>> getCachedShortcuts() async {
    try {
      final shortcuts = await localDataSource.getCachedShortcuts();
      return Right(shortcuts.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to retrieve cached shortcuts',
          code: 'CACHE_ERROR',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> cacheServices(List<Service> services) async {
    try {
      final models = services.map(ServiceModel.fromEntity).toList();
      await localDataSource.cacheServices(models);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), code: 'CACHE_ERROR'));
    }
  }

  @override
  Future<Either<Failure, void>> cacheShortcuts(List<Shortcut> shortcuts) async {
    try {
      final models = shortcuts.map(ShortcutModel.fromEntity).toList();
      await localDataSource.cacheShortcuts(models);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), code: 'CACHE_ERROR'));
    }
  }

  @override
  Future<Either<Failure, void>> cacheRestaurants(
    List<Restaurant> restaurants,
  ) async {
    try {
      final models = restaurants.map(RestaurantModel.fromEntity).toList();
      await localDataSource.cacheRestaurants(models);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), code: 'CACHE_ERROR'));
    }
  }
}
