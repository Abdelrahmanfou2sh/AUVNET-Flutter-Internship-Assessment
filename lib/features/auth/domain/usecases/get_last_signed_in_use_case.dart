import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetLastSignedInUserUseCase {
  final AuthRepository _repository;

  GetLastSignedInUserUseCase(this._repository);

  Future<Either<Failure, UserEntity?>> call() async {
    return await _repository.getLastSignedInUser();
  }
}