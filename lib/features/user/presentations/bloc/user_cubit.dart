import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../cores/utils/image_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../shared/domain/repositories/image_repository.dart';
import '../../domain/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final ImageRepository imageRepository;

  UserCubit({
    required this.userRepository,
    required this.authRepository,
    required this.imageRepository,
  }) : super(const UserInitial());

  static const avatarPath = '/avatars';

  Future<void> getUser(String userId) async {
    try {
      emit(UserLoading(state));
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

  Future<void> updatePhotoUrl() async {
    try {
      emit(UserLoading(state));
      final user = authRepository.currentUser.toEntity();

      if (user == UserEntity.empty) {
        emit(UserFailed(S.current.unauthenticated));
      } else {
        String? photoUrl = await _uploadAvatar(user.id);

        if (photoUrl?.isEmpty ?? true) {
          log('No image uploaded');
          emit(UserFailed(S.current.dataStateFailure));
        } else {
          final dataState = await userRepository.updateUserField(
              user.id, {UserEntity.avatarUrlFieldName: photoUrl});

          if (dataState is DataFailure) {
            log('Upload image failed ${dataState.error?.message}');
            emit(UserFailed(S.current.dataStateFailure));
          } else {
            await authRepository.uploadPhotoUrl(photoUrl!);
            emit(UserAvatarChanged(user: user));
          }
        }
      }
    } catch (e) {
      log('Upload photo failed: $e');
      emit(UserFailed(S.current.dataStateFailure));
    }
  }

  Future<String?> _uploadAvatar(String userId) async {
    XFile? imageFile = await ImageUtils.pickImage();
    if (imageFile == null) return null;

    final dataState = await imageRepository.uploadImage(
        imageFile.path, '$avatarPath/$userId');

    if (dataState is DataFailure) {
      return null;
    }

    return dataState.data!;
  }
}
