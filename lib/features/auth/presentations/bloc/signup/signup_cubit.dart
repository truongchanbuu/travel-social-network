import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/models/email.dart';
import '../../../data/models/password.dart';
import '../../../data/repositories/exceptions/auth_exception.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit(this.authRepository) : super(const SignupInitial());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(EmailChanged(state, email));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(PasswordChanged(state, password));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.isValid) return;
    emit(SignUpInProgressing(state));
    try {
      await authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(SignUpSucceed(state));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(SignUpFailed(state, e.message));
    } catch (_) {
      emit(SignUpFailed(state));
    }
  }
}
