import '../../../../cores/resources/data_state.dart';
import '../../data/models/user.dart';

abstract interface class AuthRepository {
  Stream<UserModel> get user;
  Future<UserModel> get currentUser;
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
