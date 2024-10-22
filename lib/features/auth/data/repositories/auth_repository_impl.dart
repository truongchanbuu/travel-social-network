import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../cores/utils/cached_client.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CacheClient _cache;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({
    CacheClient? cacheClient,
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cacheClient ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? getIt.get<FirebaseAuth>(),
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  @override
  UserEntity get currentUser => throw UnimplementedError();

  @override
  Future<DataState<void>> logInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement logInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> logInWithGoogle() {
    // TODO: implement logInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> signUp(
      {required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  // TODO: implement user
  Stream<UserEntity> get user => throw UnimplementedError();
}
