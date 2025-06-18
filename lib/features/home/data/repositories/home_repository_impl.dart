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

/// Implementation of the HomeRepository interface that handles data operations for the home feature.
/// This class manages both remote (Firestore) and local (Hive) data sources for restaurants, services, and shortcuts.
class HomeRepositoryImpl implements HomeRepository {
  /// Remote data source for fetching data from Firestore
  final HomeRemoteDataSource remoteDataSource;
  
  /// Local data source for caching data using Hive
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
  /// Fetches restaurants from the remote data source and caches them locally.
  /// Returns a Right with the list of restaurants if successful, or a Left with a ServerFailure if an error occurs.
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

  /// Fetches services from the remote data source and caches them locally.
  /// Returns a Right with the list of services if successful, or a Left with a ServerFailure if an error occurs.
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

  /// Fetches shortcuts from the remote data source and caches them locally.
  /// Returns a Right with the list of shortcuts if successful, or a Left with a ServerFailure if an error occurs.
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

  /// Retrieves cached restaurants from the local data source.
  /// Returns a Right with the list of restaurants if successful, or a Left with a CacheFailure if an error occurs.
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

  /// Retrieves cached services from the local data source.
  /// Returns a Right with the list of services if successful, or a Left with a CacheFailure if an error occurs.
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

  /// Retrieves cached shortcuts from the local data source.
  /// Returns a Right with the list of shortcuts if successful, or a Left with a CacheFailure if an error occurs.
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

  /// Caches the provided list of services in the local data source.
  /// Returns a Right with void if successful, or a Left with a ServerFailure if an error occurs.
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

  /// Caches the provided list of shortcuts in the local data source.
  /// Returns a Right with void if successful, or a Left with a ServerFailure if an error occurs.
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

  /// Caches the provided list of restaurants in the local data source.
  /// Returns a Right with void if successful, or a Left with a ServerFailure if an error occurs.
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
