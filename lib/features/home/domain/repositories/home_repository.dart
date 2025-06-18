import 'package:dartz/dartz.dart';
import 'package:auvnet/core/error/failures.dart';
import 'package:auvnet/features/home/domain/entities/restaurant.dart';
import 'package:auvnet/features/home/domain/entities/service.dart';
import 'package:auvnet/features/home/domain/entities/shortcut.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurants();
  Future<Either<Failure, List<Service>>> getServices();
  Future<Either<Failure, List<Shortcut>>> getShortcuts();

  Future<Either<Failure, void>> cacheRestaurants(List<Restaurant> restaurants);
  Future<Either<Failure, void>> cacheServices(List<Service> services);
  Future<Either<Failure, void>> cacheShortcuts(List<Shortcut> shortcuts);

  Future<Either<Failure, List<Restaurant>>> getCachedRestaurants();
  Future<Either<Failure, List<Service>>> getCachedServices();
  Future<Either<Failure, List<Shortcut>>> getCachedShortcuts();
}
