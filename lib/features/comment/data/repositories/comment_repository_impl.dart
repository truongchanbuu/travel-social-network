import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
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
  Future<DataState<Comment>> deleteComment(String commentId) async {
    try {
      final docRef = commentCollection.doc(commentId);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure(S.current.notFound);
      }

      await docRef.delete();
      return DataSuccess(data: Comment.fromJson(docSnap.data()!));
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<Comment>>> getPostRootComments(String postId) async {
    try {
      List<Comment> comments = [];

      final docSnaps = await commentCollection
          .where(CommentEntity.postIdFieldName, isEqualTo: postId)
          .where(CommentEntity.parentCommentIdFieldName, isNull: true)
          .orderBy(CommentEntity.createdAtFieldName, descending: true)
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
  Future<DataState<Comment>> updateComment(
      String commentId, Map<String, dynamic> data) async {
    try {
      final docRef = commentCollection.doc(commentId);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure(S.current.notFound);
      }

      await docRef.update(data);
      return DataSuccess(data: Comment.fromJson(docSnap.data()!));
    } on FirebaseException catch (error) {
      return handleFirebaseException(error);
    } catch (error) {
      return defaultDataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<Comment>>> getReplies(String commentId) async {
    try {
      List<Comment> comments = [];

      final docSnaps = await commentCollection
          .where(CommentEntity.parentCommentIdFieldName, isEqualTo: commentId)
          .orderBy(CommentEntity.createdAtFieldName, descending: true)
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
}
