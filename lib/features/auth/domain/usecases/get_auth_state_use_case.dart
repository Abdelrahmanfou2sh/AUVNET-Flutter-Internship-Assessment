
import 'package:auvnet/features/auth/domain/entities/user.dart';
import 'package:auvnet/features/auth/domain/repositories/auth_repository.dart';

class GetAuthStateUseCase {
  final AuthRepository repository;

  GetAuthStateUseCase(this.repository);

  Stream<UserEntity?> call() {
    return repository.authStateChanges;
  }
}