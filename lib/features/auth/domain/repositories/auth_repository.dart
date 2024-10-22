import '../../../../cores/resources/data_state.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Stream<UserEntity> get user;
  UserEntity get currentUser;
  Future<DataState<void>> signUp({
    required String email,
    required String password,
  });
  Future<DataState<void>> logInWithGoogle();
  Future<DataState<void>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<DataState<void>> logOut();
}
