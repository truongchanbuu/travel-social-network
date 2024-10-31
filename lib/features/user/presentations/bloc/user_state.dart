part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  final UserEntity user;
  const UserState({required this.user});

  @override
  List<Object> get props => [user];
}

final class UserInitial extends UserState {
  const UserInitial({super.user = UserEntity.empty});
}

final class UserLoaded extends UserState {
  const UserLoaded({required super.user});
}

final class UserFailed extends UserState {
  final String message;
  const UserFailed(this.message) : super(user: UserEntity.empty);

  @override
  List<Object> get props => [message, user];
}

final class UserLoading extends UserState {
  UserLoading(UserState current) : super(user: current.user);
}

final class UserAvatarChanged extends UserState {
  const UserAvatarChanged({required super.user});
}

final class UserEmailChanged extends UserState {
  const UserEmailChanged({required super.user});
}
