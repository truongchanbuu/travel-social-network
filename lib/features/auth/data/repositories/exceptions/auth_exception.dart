abstract class AuthFailure implements Exception {
  static const String invalidEmail = 'invalid-email';
  static const String userDisabled = 'user-disabled';
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String weakPassword = 'weak-password';
  static const String accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const String invalidCredential = 'invalid-credential';
  static const String invalidVerificationCode = 'invalid-verification-code';
  static const String invalidVerificationId = 'invalid-verification-id';

  final String? code;
  final String message;

  const AuthFailure([
    this.code,
    this.message = 'An unknown exception occurred.',
  ]);
}

class SignUpWithEmailAndPasswordFailure extends AuthFailure {
  const SignUpWithEmailAndPasswordFailure([super.message]);
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    return SignUpWithEmailAndPasswordFailure(
      _authErrorMessages[code] ?? 'An unknown exception occurred.',
    );
  }
}

class LogInWithEmailAndPasswordFailure extends AuthFailure {
  const LogInWithEmailAndPasswordFailure([super.code, super.message]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    return LogInWithEmailAndPasswordFailure(
      code,
      _authErrorMessages[code] ?? 'An unknown exception occurred.',
    );
  }
}

class LogInWithGoogleFailure extends AuthFailure {
  const LogInWithGoogleFailure([super.message]);

  factory LogInWithGoogleFailure.fromCode(String code) {
    return LogInWithGoogleFailure(
      _authErrorMessages[code] ?? 'An unknown exception occurred.',
    );
  }
}

class UpdateAccountFailure extends AuthFailure {
  const UpdateAccountFailure([super.message]);

  factory UpdateAccountFailure.fromCode(String code) {
    return UpdateAccountFailure(
      _authErrorMessages[code] ?? 'An unknown exception occurred.',
    );
  }
}

class LogOutFailure extends AuthFailure {
  const LogOutFailure([super.message]);
}

const Map<String, String> _authErrorMessages = {
  AuthFailure.invalidEmail: 'Email is not valid or badly formatted.',
  AuthFailure.userDisabled:
      'This user has been disabled. Please contact support for help.',
  AuthFailure.emailAlreadyInUse: 'An account already exists for that email.',
  AuthFailure.operationNotAllowed:
      'Operation is not allowed. Please contact support.',
  AuthFailure.weakPassword: 'Please enter a stronger password.',
  AuthFailure.userNotFound: 'Email is not found, please create an account.',
  AuthFailure.wrongPassword: 'Incorrect password, please try again.',
  AuthFailure.accountExistsWithDifferentCredential:
      'Account exists with different credentials.',
  AuthFailure.invalidCredential:
      'The credential received is malformed or has expired.',
  AuthFailure.invalidVerificationCode:
      'The credential verification code received is invalid.',
  AuthFailure.invalidVerificationId:
      'The credential verification ID received is invalid.',
};
