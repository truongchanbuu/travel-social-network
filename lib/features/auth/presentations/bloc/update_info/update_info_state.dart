part of 'update_info_cubit.dart';

sealed class UpdateAccountInfoState extends Equatable {
  final UserEntity user;
  final Password password;
  final bool isValid;
  final String? errorMessage;

  const UpdateAccountInfoState({
    required this.user,
    this.errorMessage,
    required this.isValid,
    required this.password,
  });

  @override
  List<Object?> get props => [user, errorMessage, isValid, password];
}

final class UpdateInfoInitial extends UpdateAccountInfoState {
  const UpdateInfoInitial({
    required super.user,
    super.isValid = true,
    super.password = const Password.pure(),
  });
}

final class UpdateSucceed extends UpdateAccountInfoState {
  UpdateSucceed(UpdateAccountInfoState current, UserEntity user)
      : super(user: user, isValid: current.isValid, password: current.password);
}

final class Updating extends UpdateAccountInfoState {
  Updating(UpdateAccountInfoState current)
      : super(
          user: current.user,
          isValid: current.isValid,
          password: const Password.pure(),
        );
}

final class UpdateFailed extends UpdateAccountInfoState {
  UpdateFailed({required UpdateAccountInfoState current, String? message})
      : super(
          user: current.user,
          isValid: current.isValid,
          errorMessage: message,
          password: const Password.pure(),
        );
}

final class EmailChanged extends UpdateAccountInfoState {
  EmailChanged({required UpdateAccountInfoState current, required Email email})
      : super(
          user: current.user.copyWith(email: email.value),
          isValid: Formz.validate([email]),
          password: const Password.pure(),
        );
}

final class EmailVerifying extends UpdateAccountInfoState {
  EmailVerifying(UpdateAccountInfoState current)
      : super(
          user: current.user,
          isValid: current.isValid,
          password: const Password.pure(),
        );
}

final class PasswordChanged extends UpdateAccountInfoState {
  PasswordChanged({
    required UpdateAccountInfoState current,
    required super.password,
  }) : super(
          user: current.user,
          isValid: Formz.validate([password]),
        );
}

final class PhoneNumberChanged extends UpdateAccountInfoState {
  PhoneNumberChanged({
    required UpdateAccountInfoState current,
    required Phone phone,
  }) : super(
          user: current.user.copyWith(phoneNumber: phone.value),
          isValid: Formz.validate([phone]),
          password: const Password.pure(),
        );
}

final class DisplayNameChanged extends UpdateAccountInfoState {
  DisplayNameChanged({
    required UpdateAccountInfoState current,
    required String username,
    super.password = const Password.pure(),
  }) : super(
          user: current.user.copyWith(username: username),
          isValid: username.isNotEmpty,
        );
}

final class BirthDateChanged extends UpdateAccountInfoState {
  BirthDateChanged({
    required UpdateAccountInfoState current,
    required DateTime? dateOfBirth,
    super.password = const Password.pure(),
  }) : super(
          user: current.user.copyWith(dateOfBirth: dateOfBirth),
          isValid: _validateBirthDate(dateOfBirth),
        );

  static bool _validateBirthDate(DateTime? dateOfBirth) {
    if (dateOfBirth == null) return false;

    final currentDate = DateTime.now();
    final age = currentDate.year - dateOfBirth.year;
    final isBirthdayPassedThisYear = (currentDate.month > dateOfBirth.month) ||
        (currentDate.month == dateOfBirth.month &&
            currentDate.day >= dateOfBirth.day);

    final actualAge = isBirthdayPassedThisYear ? age : age - 1;

    return actualAge >= 18 && actualAge <= 130;
  }
}
