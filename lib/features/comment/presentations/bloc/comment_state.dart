part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

final class CommentInitial extends CommentState {}

final class CommentActionFailed extends CommentState {
  final String message;
  const CommentActionFailed(this.message);

  @override
  List<Object?> get props => [message];
}

final class CommentActionLoading extends CommentState {}

final class CommentActionSucceed extends CommentState {
  final CommentEntity comment;
  const CommentActionSucceed(this.comment);

  @override
  List<Object?> get props => [comment];
}

final class ListOfCommentsReceived extends CommentState {
  final List<CommentEntity> comments;
  const ListOfCommentsReceived(this.comments);

  @override
  List<Object?> get props => [comments];
}

final class CommentDeleted extends CommentState {
  final CommentEntity comment;
  const CommentDeleted(this.comment);

  @override
  List<Object?> get props => [comment];
}

final class ListOfRepliesReceived extends CommentState {
  final List<CommentEntity> replies;
  const ListOfRepliesReceived(this.replies);

  @override
  List<Object?> get props => [replies];
}
