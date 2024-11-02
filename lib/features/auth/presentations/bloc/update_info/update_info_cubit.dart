import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:travel_social_network/cores/resources/data_state.dart';

import '../../../../../generated/l10n.dart';
import '../../../../user/domain/repositories/user_repository.dart';
import '../../../data/models/email.dart';
import '../../../data/models/password.dart';
import '../../../data/models/phone.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/exceptions/auth_exception.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'update_info_state.dart';

class UpdateAccountInfoCubit extends Cubit<UpdateAccountInfoState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  UpdateAccountInfoCubit(
      {required this.authRepository, required this.userRepository})
      : super(UpdateInfoInitial(user: authRepository.currentUser.toEntity()));

  bool get isUserChanged => state.user != authRepository.currentUser.toEntity();

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(EmailChanged(current: state, email: email));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(PasswordChanged(current: state, password: password));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = Phone.dirty(value);
    emit(PhoneNumberChanged(current: state, phone: phoneNumber));
  }

  void displayNameChanged(String value) {
    emit(DisplayNameChanged(current: state, username: value));
  }

  void birthDateChanged(DateTime? value) {
    emit(BirthDateChanged(current: state, dateOfBirth: value));
  }

  static const timeoutInSecond = 15 * 60;
  Future<void> updateAccount() async {
    try {
      if (state.isValid) {
        if (state is EmailChanged) {
          await _updateEmail();
        } else if (state is PasswordChanged) {
          await _updatePassword();
        } else if (state is PhoneNumberChanged) {
          await _updatePhone();
        } else if (state is DisplayNameChanged) {
          await _updateDisplayName();
        } else if (state is BirthDateChanged) {
          await _updateBirthDate();
        }

        emit(UpdateSucceed(state, authRepository.currentUser));
      } else {
        emit(UpdateFailed(current: state, message: S.current.invalidInput));
      }
    } on UpdateAccountFailure catch (e) {
      emit(UpdateFailed(current: state, message: e.message));
    } catch (e) {
      emit(UpdateFailed(current: state, message: e.toString()));
    }
  }

  Future<void> _updateEmail() async {
    await authRepository.updateEmail(state.user.email!);

    emit(EmailVerifying(state));

    bool isVerified = await _waitForEmailVerification(
        timeout: const Duration(seconds: timeoutInSecond));

    if (!isVerified) {
      throw Exception('Email verification timeout');
    }

    final dataState = await userRepository.updateUserField(state.user.id, {
      UserEntity.emailFieldName: state.user.email,
      UserEntity.isVerifiedFieldName: true,
    });

    if (dataState is DataFailure) {
      log('Update email failed: ${dataState.error?.message}');
      emit(UpdateFailed(current: state));
    } else {
      emit(UpdateSucceed(state, authRepository.currentUser.toEntity()));
    }
  }

  Future<void> _updatePassword() async {
    await authRepository.updatePassword(state.password.value);
  }

  Future<void> _updatePhone() async {
    // await authRepository.updatePassword(state.user.phoneNumber);
    await userRepository.updateUserField(state.user.id, {
      UserEntity.phoneNumberFieldName: state.user.phoneNumber,
    });
  }

  Future<void> _updateDisplayName() async {
    await userRepository.updateUserField(
        state.user.id, {UserEntity.usernameFieldName: state.user.username});
  }

  Future<void> _updateBirthDate() async {
    await userRepository.updateUserField(state.user.id, {
      UserEntity.dateOfBirthFieldName: state.user.dateOfBirth?.toIso8601String()
    });
  }

  Future<bool> _waitForEmailVerification({required Duration timeout}) async {
    final completer = Completer<bool>();

    Timer? timeoutTimer;
    StreamSubscription<UserModel>? userStream;

    timeoutTimer = Timer(
      timeout,
      () {
        userStream?.cancel();
        if (!completer.isCompleted) completer.complete(false);
      },
    );

    userStream = Stream.periodic(
      const Duration(seconds: 5),
      (_) => authRepository.currentUser,
    )
        .asyncMap(
          (user) async {
            if (user.toEntity() != UserEntity.empty) {
              await authRepository.reload();

              return authRepository.currentUser;
            }

            return UserModel.fromEntity(UserEntity.empty);
          },
        )
        .where((user) => user != UserEntity.empty)
        .listen(
          (user) {
            if (user.email == state.user.email) {
              userStream?.cancel();
              timeoutTimer?.cancel();
              if (!completer.isCompleted) {
                completer.complete(true);
              }
            }
          },
          onError: (error) {
            userStream?.cancel();
            timeoutTimer?.cancel();
            if (!completer.isCompleted) {
              if (error is FirebaseAuthException &&
                  error.code == AuthFailure.userTokenExpired) {
                completer.complete(true);
              } else {
                completer.complete(false);
              }
            }
          },
        );

    return completer.future;
  }
}
