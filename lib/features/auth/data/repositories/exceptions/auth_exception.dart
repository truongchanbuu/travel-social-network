abstract class AuthFailure implements Exception {
  final String message;
  const AuthFailure([this.message = 'An unknown exception occurred.']);
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
  const LogInWithEmailAndPasswordFailure([super.message]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    return LogInWithEmailAndPasswordFailure(
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

class LogOutFailure extends AuthFailure {
  const LogOutFailure([super.message]);
}

const Map<String, String> _authErrorMessages = {
  'invalid-email': 'Email is not valid or badly formatted.',
  'user-disabled':
      'This user has been disabled. Please contact support for help.',
  'email-already-in-use': 'An account already exists for that email.',
  'operation-not-allowed': 'Operation is not allowed. Please contact support.',
  'weak-password': 'Please enter a stronger password.',
  'user-not-found': 'Email is not found, please create an account.',
  'wrong-password': 'Incorrect password, please try again.',
  'account-exists-with-different-credential':
      'Account exists with different credentials.',
  'invalid-credential': 'The credential received is malformed or has expired.',
  'invalid-verification-code':
      'The credential verification code received is invalid.',
  'invalid-verification-id':
      'The credential verification ID received is invalid.',
};
