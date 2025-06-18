import 'package:auvnet/features/home/domain/entities/service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:auvnet/core/error/failures.dart';
import 'package:auvnet/features/home/domain/repositories/home_repository.dart';

class GetServicesUseCase {
  final HomeRepository repository;

  GetServicesUseCase(this.repository);

  Future<Either<Failure, List<Service>>> call() async {
    try {
      debugPrint('🟡 Trying to get cached restaurants...');
      final cachedResult = await repository.getCachedServices();

      final hasCachedData = cachedResult.fold(
        (failure) => false,
        (list) => list.isNotEmpty,
      );

      if (hasCachedData) {
        debugPrint('✅ Loaded restaurants from cache.');
        return cachedResult;
      }

      debugPrint('📡 No cache. Fetching from Firestore...');
      final remoteResult = await repository.getServices();

      remoteResult.fold(
        (failure) => debugPrint('❌ Failed to fetch from remote: $failure'),
        (services) async {
          debugPrint('✅ Fetched from Firestore. Caching...');
          await repository.cacheServices(services);
        },
      );

      return remoteResult;
    } catch (e) {
      debugPrint('❌ Unexpected error in usecase: $e');
      return Left(ServerFailure(message: e.toString(), code: 'USECASE_ERROR'));
    }
  }
}
