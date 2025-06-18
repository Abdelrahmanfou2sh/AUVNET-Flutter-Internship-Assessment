import 'package:auvnet/features/home/domain/entities/shortcut.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:auvnet/core/error/failures.dart';
import 'package:auvnet/features/home/domain/repositories/home_repository.dart';

class GetShortcutsUseCase {
  final HomeRepository repository;

  GetShortcutsUseCase(this.repository);

  Future<Either<Failure, List<Shortcut>>> call() async {
    try {
      debugPrint('🟡 Trying to get cached restaurants...');
      final cachedResult = await repository.getCachedShortcuts();

      final hasCachedData = cachedResult.fold(
        (failure) => false,
        (list) => list.isNotEmpty,
      );

      if (hasCachedData) {
        debugPrint('✅ Loaded restaurants from cache.');
        return cachedResult;
      }

      debugPrint('📡 No cache. Fetching from Firestore...');
      final remoteResult = await repository.getShortcuts();

      remoteResult.fold(
        (failure) => debugPrint('❌ Failed to fetch from remote: $failure'),
        (shortcuts) async {
          debugPrint('✅ Fetched from Firestore. Caching...');
          await repository.cacheShortcuts(shortcuts);
        },
      );

      return remoteResult;
    } catch (e) {
      debugPrint('❌ Unexpected error in usecase: $e');
      return Left(ServerFailure(message: e.toString(), code: 'USECASE_ERROR'));
    }
  }
}
