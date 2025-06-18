import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String code;

  const Failure({required this.message, required this.code});

  @override
  List<Object> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.code});

  factory ServerFailure.fromException(Exception exception) {
    return ServerFailure(message: exception.toString(), code: 'SERVER_ERROR');
  }
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.code});

  factory CacheFailure.fromException(Exception exception) {
    return CacheFailure(message: exception.toString(), code: 'CACHE_ERROR');
  }
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, required super.code});

  factory AuthFailure.fromException(Exception exception) {
    final message = exception.toString();
    if (message.contains('wrong-password')) {
      return const AuthFailure(
        message: 'Invalid password',
        code: 'INVALID_PASSWORD',
      );
    } else if (message.contains('user-not-found')) {
      return const AuthFailure(
        message: 'User not found',
        code: 'USER_NOT_FOUND',
      );
    } else if (message.contains('email-already-in-use')) {
      return const AuthFailure(
        message: 'Email already in use',
        code: 'EMAIL_ALREADY_IN_USE',
      );
    } else if (message.contains('invalid-email')) {
      return const AuthFailure(message: 'Invalid email', code: 'INVALID_EMAIL');
    } else if (message.contains('weak-password')) {
      return const AuthFailure(message: 'Weak password', code: 'WEAK_PASSWORD');
    }
    return AuthFailure(message: message, code: 'AUTH_ERROR');
  }
}
