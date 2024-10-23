import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AppAuthState()) {
    on<AuthUserSubscriptionRequest>(_onUserSubscriptionRequested);
    on<LogoutRequest>(_onLogout);
  }

  Future<void> _onUserSubscriptionRequested(
    AuthUserSubscriptionRequest event,
    Emitter<AuthState> emit,
  ) {
    return emit.onEach(
      authRepository.user,
      onData: (user) => emit(AppAuthState(user: user.toEntity())),
      onError: addError,
    );
  }

  void _onLogout(
    LogoutRequest event,
    Emitter<AuthState> emit,
  ) {
    authRepository.logOut();
  }
}
