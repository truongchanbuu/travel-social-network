part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

final class CreateCommentEvent extends CommentEvent {
  final Comment comment;
  const CreateCommentEvent(this.comment);

  @override
  List<Object?> get props => [comment];
}
