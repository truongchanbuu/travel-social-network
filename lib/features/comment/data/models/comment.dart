import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/comment.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment extends CommentEntity {
  const Comment({
    required super.commentId,
    required super.content,
    required super.likedUsers,
    required super.userId,
    required super.createdAt,
    required super.postId,
    super.parentCommentId,
    super.updatedAt,
  });

  CommentEntity toEntity() {
    return CommentEntity(
      commentId: commentId,
      content: content,
      likedUsers: likedUsers,
      userId: userId,
      createdAt: createdAt,
      postId: postId,
      updatedAt: updatedAt,
      parentCommentId: parentCommentId,
    );
  }

  factory Comment.fromEntity(CommentEntity entity) {
    return Comment(
      commentId: entity.commentId,
      content: entity.content,
      likedUsers: entity.likedUsers,
      userId: entity.userId,
      createdAt: entity.createdAt,
      postId: entity.postId,
      parentCommentId: entity.parentCommentId,
      updatedAt: entity.updatedAt,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
