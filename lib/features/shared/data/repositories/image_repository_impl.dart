import 'package:firebase_storage/firebase_storage.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../injection_container.dart';
import '../../domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final FirebaseStorage _storage = getIt.get<FirebaseStorage>();

  @override
  Future<DataState<dynamic>> deleteImage(String path) async {
    try {
      final ref = _storage.ref(path);
      await ref.delete();
      return const DataSuccess();
    } on FirebaseException catch (e) {
      return handleFirebaseException<String>(e);
    } catch (e) {
      return defaultDataFailure<String>(e.toString());
    }
  }

  @override
  Future<DataState<dynamic>> downloadImage(String path) {
    // TODO: implement downloadImage
    throw UnimplementedError();
  }

  @override
  Future<DataState<String>> getImageUrl(String path) async {
    try {
      final ref = _storage.ref(path);
      return DataSuccess(data: await ref.getDownloadURL());
    } on FirebaseException catch (e) {
      return handleFirebaseException<String>(e);
    } catch (e) {
      return defaultDataFailure<String>(e.toString());
    }
  }

  @override
  Future<DataState<String>> uploadImage(image, String path) async {
    try {
      final ref = _storage.ref(path);
      await ref.putData(image);
      return DataSuccess(data: await ref.getDownloadURL());
    } on FirebaseException catch (e) {
      return handleFirebaseException<String>(e);
    } catch (e) {
      return defaultDataFailure<String>(e.toString());
    }
  }
}