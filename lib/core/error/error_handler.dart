import 'dart:io';
import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  static Failure handle(Exception exception) {
    if (exception is AuthException) {
      return AuthFailure.fromException(exception);
    }

    if (exception is ServerException) {
      return ServerFailure.fromException(exception);
    }

    if (exception is SocketException) {
      return ServerFailure(
        message: 'No Internet Connection',
        code: 'NO_INTERNET',
      );
    }

    if (exception is NetworkException) {
      return ServerFailure(
        message: exception.toString(),
        code: 'NETWORK_ERROR',
      );
    }

    return ServerFailure(
      message: exception.toString(),
      code: 'UNEXPECTED_ERROR',
    );
  }
}