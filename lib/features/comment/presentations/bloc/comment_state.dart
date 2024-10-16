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
