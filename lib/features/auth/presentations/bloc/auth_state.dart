part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

sealed class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity user;
  const AuthState({required this.status, required this.user});

  @override
  List<Object> get props => [status, user];
}

final class AppAuthState extends AuthState {
  const AppAuthState({super.user = UserEntity.empty})
      : super(
          status: user != UserEntity.empty
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
        );
}
