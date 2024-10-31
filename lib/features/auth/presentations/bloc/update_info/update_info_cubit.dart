import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../user/domain/repositories/user_repository.dart';
import '../../../data/models/email.dart';
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

  Future<void> emailChanged(String value) async {
    final email = Email.dirty(value);
    emit(EmailChanged(current: state, email: email));
  }

  static const timeoutInSecond = 3600;
  Future<void> updateAccount() async {
    try {
      if (state is EmailChanged) {
        await authRepository.updateEmail(state.user.email!);

        bool isVerified = await _waitForEmailVerification(
            timeout: const Duration(seconds: timeoutInSecond));

        print("IS VERIFIED: $isVerified");
        if (!isVerified) {
          throw Exception('Email verification timeout');
        }

        await userRepository.updateUserField(state.user.id, {
          UserEntity.emailFieldName: state.user.email,
          UserEntity.isVerifiedFieldName: true,
        });
        emit(UpdateSucceed(state));
      }
    } on UpdateAccountFailure catch (e) {
      emit(UpdateFailed(current: state, message: e.message));
    } catch (e) {
      emit(UpdateFailed(current: state, message: e.toString()));
    }
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

    userStream = authRepository.user.listen((currentUser) {
      if (currentUser.isVerified) {
        timeoutTimer?.cancel();
        userStream?.cancel();

        if (!completer.isCompleted) {
          completer.complete(true);
        }
      }
    });

    return completer.future;
  }
}
