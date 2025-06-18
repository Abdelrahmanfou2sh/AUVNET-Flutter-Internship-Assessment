import 'package:firebase_auth/firebase_auth.dart';
import 'exceptions.dart';
import 'firebase_error_codes.dart';

/// Maps [FirebaseException] errors to app-specific [Exception] types:
/// - [AuthException] for authentication-related errors
/// - [NetworkException] for connectivity issues
/// - [ServerException] for general backend problems
///
/// This improves error readability and consistency across the app.
class FirebaseErrorHandler {
  static Exception handle(FirebaseException error) {
    switch (error.code) {
      case FirebaseErrorCodes.userNotFound:
        return AuthException('User not found');

      case FirebaseErrorCodes.wrongPassword:
        return AuthException('Invalid password');

      case FirebaseErrorCodes.invalidEmail:
        return AuthException('Invalid email');

      case FirebaseErrorCodes.userDisabled:
        return AuthException('This email has been disabled');

      case FirebaseErrorCodes.emailAlreadyInUse:
        return AuthException('Email is already in use');

      case FirebaseErrorCodes.operationNotAllowed:
        return AuthException('This operation is not allowed');

      case FirebaseErrorCodes.weakPassword:
        return AuthException('Password is too weak');

      case FirebaseErrorCodes.tooManyRequests:
        return AuthException('Too many requests. Please try again later');

      case FirebaseErrorCodes.networkRequestFailed:
        return NetworkException('Network request failed');

      case FirebaseErrorCodes.invalidVerificationCode:
        return AuthException('Invalid verification code');

      case FirebaseErrorCodes.invalidVerificationId:
        return AuthException('Invalid verification ID');

      case FirebaseErrorCodes.quotaExceeded:
        return ServerException('Firebase quota exceeded');

      case FirebaseErrorCodes.providerAlreadyLinked:
        return AuthException('This provider is already linked');

      case FirebaseErrorCodes.credentialAlreadyInUse:
        return AuthException('Credentials are already in use');

      case FirebaseErrorCodes.requiresRecentLogin:
        return AuthException('Please log in again to perform this action');

      default:
        return ServerException(error.message ?? 'An unexpected error occurred');
    }
  }
}
