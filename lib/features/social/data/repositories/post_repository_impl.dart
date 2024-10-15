import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post.dart';

class PostRepositoryImpl implements PostRepository {
  final postCollection = firestore.collection('posts');

  @override
  Future<DataState<Post>> createPost(Post post) async {
    try {
      await postCollection.doc(post.postId).set(post.toJson());
      return DataSuccess(data: post);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }
}
