part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzSubmissionStatus formStatus;
  final bool isValid;
  final String? errorMessage;

  const LoginState({
    required this.email,
    required this.password,
    required this.formStatus,
    required this.isValid,
    required this.errorMessage,
  });

  @override
  List<Object?> get props =>
      [email, password, formStatus, isValid, errorMessage];
}

final class LoginInitial extends LoginState {
  const LoginInitial({
    super.email = const Email.pure(),
    super.password = const Password.pure(),
    super.formStatus = FormzSubmissionStatus.initial,
    super.isValid = false,
    super.errorMessage,
  });
}

final class EmailChanged extends LoginState {
  EmailChanged(LoginState current, Email email)
      : super(
          email: email,
          isValid: Formz.validate([email, current.password]),
          password: current.password,
          errorMessage: current.errorMessage,
          formStatus: current.formStatus,
        );
}

final class PasswordChanged extends LoginState {
  PasswordChanged(LoginState current, Password password)
      : super(
          password: password,
          isValid: Formz.validate([current.email, password]),
          email: current.email,
          errorMessage: current.errorMessage,
          formStatus: current.formStatus,
        );
}

final class LoginInProgressing extends LoginState {
  LoginInProgressing(LoginState current)
      : super(
          email: current.email,
          password: current.password,
          formStatus: FormzSubmissionStatus.inProgress,
          isValid: current.isValid,
          errorMessage: current.errorMessage,
        );
}

final class LoginSucceed extends LoginState {
  LoginSucceed(LoginState current)
      : super(
          email: current.email,
          password: current.password,
          formStatus: FormzSubmissionStatus.success,
          isValid: current.isValid,
          errorMessage: current.errorMessage,
        );
}

final class LoginFailed extends LoginState {
  LoginFailed(LoginState current, [String? errorMessage])
      : super(
          email: current.email,
          password: current.password,
          formStatus: FormzSubmissionStatus.failure,
          isValid: current.isValid,
          errorMessage: errorMessage,
        );
}

final class LoginEmailNotFound extends LoginState {
  LoginEmailNotFound(LoginState current)
      : super(
          email: current.email,
          password: current.password,
          formStatus: FormzSubmissionStatus.failure,
          isValid: current.isValid,
          errorMessage: current.errorMessage,
        );
}
