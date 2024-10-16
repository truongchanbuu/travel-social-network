import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../domain/repositories/comment_repository.dart';
import '../models/comment.dart';

class CommentRepositoryImpl implements CommentRepository {
  final commentCollection = firestore.collection('comments');

  @override
  Future<DataState<Comment>> createComment(Comment comment) async {
    try {
      await commentCollection.doc(comment.commentId).set(comment.toJson());
      return DataSuccess(data: comment);
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<void>> deleteComment(String commentId) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<DataState<Comment>> getPostComment(String postId) {
    // TODO: implement getPostComment
    throw UnimplementedError();
  }

  @override
  Future<DataState<Comment>> updateComment(String commentId) {
    // TODO: implement updateComment
    throw UnimplementedError();
  }
}
