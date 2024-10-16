import '../../../../cores/resources/data_state.dart';
import '../../data/models/comment.dart';

abstract interface class CommentRepository {
  Future<DataState<Comment>> createComment(Comment comment);
  Future<DataState<void>> deleteComment(String commentId);
  Future<DataState<List<Comment>>> getPostComments(String postId);
  Future<DataState<Comment>> updateComment(String commentId);
}
