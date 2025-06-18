/// Holds Firebase error code constants to avoid hardcoded strings.
abstract class FirebaseErrorCodes {
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String invalidEmail = 'invalid-email';
  static const String userDisabled = 'user-disabled';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String weakPassword = 'weak-password';
  static const String tooManyRequests = 'too-many-requests';
  static const String networkRequestFailed = 'network-request-failed';
  static const String invalidVerificationCode = 'invalid-verification-code';
  static const String invalidVerificationId = 'invalid-verification-id';
  static const String quotaExceeded = 'quota-exceeded';
  static const String providerAlreadyLinked = 'provider-already-linked';
  static const String credentialAlreadyInUse = 'credential-already-in-use';
  static const String requiresRecentLogin = 'requires-recent-login';
}