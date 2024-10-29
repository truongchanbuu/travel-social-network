import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserCubit(this.userRepository) : super(const UserInitial());

  Future<void> getUser(String userId) async {
    try {
      emit(const UserLoading());
      final dataState = await userRepository.getUserById(userId);

      if (dataState is DataFailure) {
        emit(UserFailed(dataState.error?.message ?? 'Failed to load user'));
      } else {
        emit(UserLoaded(user: dataState.data!.toEntity()));
      }
    } catch (e) {
      log('Get user failed: $e');
      emit(UserFailed(S.current.dataStateFailure));
    }
  }
}
