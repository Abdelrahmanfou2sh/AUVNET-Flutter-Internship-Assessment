import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _remoteDataSource.signInWithEmailAndPassword(
        email,
        password,
      );
      return Right(user);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _remoteDataSource.signUpWithEmailAndPassword(
        email,
        password,
      );
      return Right(user);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges =>
      _remoteDataSource.authStateChanges;

  @override
  Future<Either<Failure, UserEntity?>> getLastSignedInUser() async {
    try {
      final user = await _localDataSource.getLastUser();
      return Right(user);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
