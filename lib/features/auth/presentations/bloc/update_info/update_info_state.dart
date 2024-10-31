part of 'update_info_cubit.dart';

sealed class UpdateAccountInfoState extends Equatable {
  final UserEntity user;
  final bool isValid;
  final String? errorMessage;

  const UpdateAccountInfoState({
    required this.user,
    this.errorMessage,
    required this.isValid,
  });

  @override
  List<Object?> get props => [user, errorMessage, isValid];
}

final class UpdateInfoInitial extends UpdateAccountInfoState {
  const UpdateInfoInitial({
    required super.user,
    super.isValid = true,
  });
}

final class UpdateSucceed extends UpdateAccountInfoState {
  UpdateSucceed(UpdateAccountInfoState current)
      : super(user: current.user, isValid: current.isValid);
}

final class UpdateFailed extends UpdateAccountInfoState {
  UpdateFailed({required UpdateAccountInfoState current, String? message})
      : super(
          user: current.user,
          isValid: current.isValid,
          errorMessage: message,
        );
}

final class EmailChanged extends UpdateAccountInfoState {
  EmailChanged({required UpdateAccountInfoState current, required Email email})
      : super(
          user: current.user.copyWith(email: email.value),
          isValid: Formz.validate([email]),
        );
}
