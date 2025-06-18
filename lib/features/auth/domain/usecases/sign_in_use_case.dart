import 'package:auvnet/core/error/failures.dart';
import 'package:auvnet/features/auth/domain/entities/user.dart';
import 'package:auvnet/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signInWithEmailAndPassword(email, password);
  }
}