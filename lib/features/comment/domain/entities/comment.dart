import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String commentId;
  final String content;
  final List<String> likedUsers;
  final String userId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String postId;
  final String? parentCommentId;

  const CommentEntity({
    required this.commentId,
    required this.content,
    required this.likedUsers,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
    required this.postId,
    this.parentCommentId,
  });

  @override
  List<Object?> get props => [
        commentId,
        content,
        likedUsers,
        userId,
        postId,
        parentCommentId,
        createdAt,
        updatedAt,
      ];
}
