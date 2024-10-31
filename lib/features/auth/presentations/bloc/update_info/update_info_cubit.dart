import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:travel_social_network/cores/resources/data_state.dart';

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

  Future<void> passwordChanged(String value) async {}

  static const timeoutInSecond = 15 * 60;
  Future<void> updateAccount() async {
    try {
      if (state is EmailChanged) {
        await authRepository.updateEmail(state.user.email!);

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

    userStream = Stream.periodic(
      const Duration(seconds: 5),
      (_) => authRepository.currentUser,
    ).asyncMap(
      (user) async {
        print('usr: $user');
        if (user.toEntity() != UserEntity.empty) {
          final updated = await authRepository.reload();
          print("HERE $updated");
          return updated;
        }

        return UserModel.fromEntity(UserEntity.empty);
      },
    ).listen(
      (user) {
        print('list: $user - is verified ${user.isVerified}');
        if (user.isVerified) {
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
          completer.complete(false);
        }
      },
    );

    return completer.future;
  }
}
