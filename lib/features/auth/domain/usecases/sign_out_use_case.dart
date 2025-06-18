import 'package:auvnet/core/error/failures.dart';
import 'package:auvnet/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
