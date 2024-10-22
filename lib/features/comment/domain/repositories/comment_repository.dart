import '../../../../cores/resources/data_state.dart';
import '../../data/models/comment.dart';

abstract interface class CommentRepository {
  Future<DataState<Comment>> createComment(Comment comment);
  Future<DataState<Comment>> deleteComment(String commentId);
  Future<DataState<List<Comment>>> getPostRootComments(String postId);
  Future<DataState<List<Comment>>> getReplies(String commentId);
  Future<DataState<Comment>> updateComment(
      String commentId, Map<String, dynamic> data);
  Future<DataState<int>> countAllPostComment(String postId);
}
