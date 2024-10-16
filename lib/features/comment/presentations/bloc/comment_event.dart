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
