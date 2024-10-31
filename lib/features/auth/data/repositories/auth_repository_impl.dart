import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../cores/constants/storage_keys.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../cores/utils/cached_client.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user.dart';
import 'exceptions/auth_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CacheClient cache;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final UserRepository userRepository;

  AuthRepositoryImpl({
    required this.cache,
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.userRepository,
  });

  bool isWeb = kIsWeb;

  @override
  Stream<UserModel> get user =>
      firebaseAuth.authStateChanges().map((firebaseUser) {
        final user = firebaseUser == null
            ? UserModel.fromEntity(UserEntity.empty)
            : UserModel.fromEntity(firebaseUser.toUser);
        cache
            .setString(StorageKeys.appUserCachedKey, jsonEncode(user.toJson()))
            .catchError((error) => log("Failed to cached user: $error"));
        return user;
      });

  @override
  UserModel get currentUser {
    try {
      final data = cache.getString(StorageKeys.appUserCachedKey);
      if (data == null) return UserModel.fromEntity(UserEntity.empty);
      return UserModel.fromJson(jsonDecode(data));
    } catch (error) {
      log("Failed to get current user: $error");
      return UserModel.fromEntity(UserEntity.empty);
    }
  }

  @override
  Future<DataState<void>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return const DataSuccess();
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<DataState<void>> logInWithGoogle() async {
    try {
      late final AuthCredential credential;
      if (isWeb) {
        final googleProvider = GoogleAuthProvider();
        final userCredential =
            await firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await firebaseAuth.signInWithCredential(credential);
      return const DataSuccess();
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<DataState<void>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!.toUser;
      await userRepository.createUser(UserModel.fromEntity(user));

      return const DataSuccess();
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<DataState<void>> logOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);

      return const DataSuccess();
    } catch (_) {
      throw const LogOutFailure();
    }
  }

  @override
  Future<DataState<void>> reAuthenticate({
    required String email,
    required String password,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);

      return const DataSuccess();
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<DataState<void>> logInWithPhone(String phoneNumber) {
    // TODO: implement logInWithPhone
    throw UnimplementedError();
  }

  @override
  Future<void> uploadPhotoUrl(String photoUrl) async {
    await firebaseAuth.currentUser!.updatePhotoURL(photoUrl);
  }

  @override
  Future<void> updateEmail(String email) async {
    await firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email);
  }
}

extension on User {
  UserEntity get toUser {
    return UserEntity(
      id: uid,
      email: email,
      avatarUrl: photoURL,
      username: displayName,
      phoneNumber: phoneNumber,
      isVerified: emailVerified,
    );
  }
}
