import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/models/email.dart';
import '../../../data/models/password.dart';
import '../../../data/repositories/exceptions/auth_exception.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository) : super(const LoginInitial());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(EmailChanged(state, email));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(PasswordChanged(state, password));
  }

  Future<void> logInWithGoogle() async {
    emit(LoginInProgressing(state));
    try {
      await authRepository.logInWithGoogle();
      emit(LoginSucceed(state));
    } on LogInWithGoogleFailure catch (e) {
      emit(LoginFailed(state, e.message));
    } catch (_) {
      emit(LoginFailed(state));
    }
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
    emit(LoginInProgressing(state));
    try {
      await authRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(LoginSucceed(state));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      if (e.code == AuthFailure.userNotFound ||
          e.code == AuthFailure.invalidCredential) {
        emit(LoginEmailNotFound(state));
      } else {
        emit(LoginFailed(state, e.message));
      }
    } catch (_) {
      emit(LoginFailed(state));
    }
  }
}
