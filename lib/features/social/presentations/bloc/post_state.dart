part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  final List<ImageFile> images;
  final String content;

  const PostState({this.images = const [], this.content = ''});

  @override
  List<Object?> get props => [images, content];
}

final class PostInitial extends PostState {}

final class ContentUpdated extends PostState {
  const ContentUpdated({
    required super.images,
    required super.content,
  });

  @override
  List<Object?> get props => [content, images];
}

final class PostActionFailed extends PostState {
  final String message;
  const PostActionFailed(this.message);

  @override
  List<Object?> get props => [message];
}

final class PostActionSucceed extends PostState {
  final PostEntity post;
  const PostActionSucceed(this.post);

  @override
  List<Object?> get props => [post];
}

final class ListOfPostReceived extends PostState {
  final List<PostEntity> posts;
  const ListOfPostReceived(this.posts);

  @override
  List<Object?> get props => [posts];
}

final class PostActionLoading extends PostState {}

final class PostDeleted extends PostState {}
