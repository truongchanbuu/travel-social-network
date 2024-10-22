part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

final class CreateCommentEvent extends CommentEvent {
  final String userId;
  final String content;
  final String postId;

  const CreateCommentEvent({
    required this.userId,
    required this.content,
    required this.postId,
  });

  @override
  List<Object?> get props => [content, userId, postId];
}

final class GetPostCommentsEvent extends CommentEvent {
  final String postId;
  const GetPostCommentsEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

final class DeleteCommentEvent extends CommentEvent {
  final String commentId;
  const DeleteCommentEvent(this.commentId);

  @override
  List<Object?> get props => [commentId];
}

final class UpdateCommentEvent extends CommentEvent {
  final String commentId;
  final Map<String, dynamic> data;

  const UpdateCommentEvent(this.commentId, this.data);

  @override
  List<Object?> get props => [commentId, data];
}

final class InitializeReplyEvent extends CommentEvent {
  final String commentOwner;
  final String parentCommentId;
  final String postId;
  final String userId;

  const InitializeReplyEvent({
    required this.parentCommentId,
    required this.postId,
    required this.userId,
    required this.commentOwner,
  });

  @override
  List<Object?> get props => [parentCommentId, postId, userId, commentOwner];
}

final class GetRepliesEvent extends CommentEvent {
  final String parentCommentId;
  const GetRepliesEvent(this.parentCommentId);

  @override
  List<Object?> get props => [parentCommentId];
}

final class CreateReplyEvent extends CommentEvent {
  final CommentEntity comment;
  const CreateReplyEvent(this.comment);

  @override
  List<Object?> get props => [comment];
}

final class GetPostCommentsCountEvent extends CommentEvent {
  final String postId;
  const GetPostCommentsCountEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

final class UpdatingCommentEvent extends CommentEvent {
  final CommentEntity comment;
  const UpdatingCommentEvent(this.comment);

  @override
  List<Object?> get props => [comment];
}
