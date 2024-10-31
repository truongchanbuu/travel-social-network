import '../../../../cores/resources/data_state.dart';
import '../../data/models/user.dart';

abstract interface class AuthRepository {
  Stream<UserModel> get user;
  UserModel get currentUser;
  Future<UserModel> reload();

  Future<DataState<void>> signUp({
    required String email,
    required String password,
  });
  Future<DataState<void>> logInWithGoogle();
  Future<DataState<void>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<DataState<void>> logInWithPhone(String phoneNumber);
  Future<DataState<void>> logOut();
  Future<DataState<void>> reAuthenticate(
      {required String email, required String password});

  Future<void> uploadPhotoUrl(String photoUrl);
  Future<void> updateEmail(String email);
}
