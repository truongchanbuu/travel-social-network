import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError {
  invalid,
  different,
}

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  static final RegExp _passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    if (value == null || !_passwordRegExp.hasMatch(value)) {
      return ConfirmPasswordValidationError.invalid;
    }

    if (value != password) {
      return ConfirmPasswordValidationError.different;
    }

    return null;
  }
}
