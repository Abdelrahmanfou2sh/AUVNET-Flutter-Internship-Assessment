import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, void>> signOut();
  Stream<UserEntity?> get authStateChanges;
  Future<Either<Failure, UserEntity?>> getLastSignedInUser();
}
