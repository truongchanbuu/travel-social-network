import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../domain/entities/comment.dart';
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
  Future<DataState<void>> deleteComment(String commentId) async {
    try {
      await commentCollection.doc(commentId).delete();
      return const DataSuccess();
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<Comment>>> getPostComments(String postId) async {
    try {
      List<Comment> comments = [];

      final docSnaps = await commentCollection
          .where(CommentEntity.postIdFieldName, isEqualTo: postId)
          .get();

      for (var doc in docSnaps.docs) {
        final comment = Comment.fromJson(doc.data());
        comments.add(comment);
      }

      return DataSuccess(data: comments);
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<Comment>> updateComment(String commentId) {
    // TODO: implement updateComment
    throw UnimplementedError();
  }
}
