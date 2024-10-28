import 'package:firebase_auth/firebase_auth.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/data/models/user.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final userCollection = firestore.collection('users');

  @override
  Future<DataState<UserModel>> createUser(UserModel user) async {
    try {
      await userCollection
          .doc(user.id)
          .set(user.copyWith(createdAt: DateTime.now()).toJson());
      return DataSuccess(data: user);
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<void>> deleteUser(String userId) async {
    try {
      final docRef = userCollection.doc(userId);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure(S.current.notFound);
      }

      await docRef.delete();
      return const DataSuccess();
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<UserModel>>> getAllUsers() async {
    try {
      List<UserModel> users = [];

      final docSnaps = await userCollection.get();

      for (var doc in docSnaps.docs) {
        final user = UserModel.fromJson(doc.data());
        users.add(user);
      }

      return DataSuccess(data: users);
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<UserModel>> getUserByEmail(String email) async {
    try {
      final docRef = userCollection
          .where(UserEntity.emailFieldName, isEqualTo: email)
          .limit(1);
      final docSnap = await docRef.get();

      if (docSnap.docs.isEmpty) {
        return defaultDataFailure(S.current.notFound);
      }

      return DataSuccess(data: UserModel.fromJson(docSnap.docs.first.data()));
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<UserModel>> getUserById(String userId) async {
    try {
      final data = await userCollection.doc(userId).get();

      if (!data.exists) {
        return defaultDataFailure(S.current.notFound);
      }

      return DataSuccess(data: UserModel.fromJson(data.data()!));
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<void>> softDeleteUser(String userId) {
    // TODO: implement softDeleteUser
    throw UnimplementedError();
  }

  @override
  Stream<DataState<UserModel>> streamUser(String userId) {
    // TODO: implement streamUser
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> updateUser(UserModel user) async {
    try {
      await userCollection
          .doc(user.id)
          .update(user.copyWith(updatedAt: DateTime.now()).toJson());

      return const DataSuccess();
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<void>> updateUserField(
      String userId, Map<String, dynamic> fields) async {
    try {
      fields['updatedAt'] = DateTime.now().toIso8601String();

      await userCollection.doc(userId).update(fields);
      return const DataSuccess();
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }
}
