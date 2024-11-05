part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

final class UpdateContentEvent extends PostEvent {
  final List<ImageFile> images;
  final String content;
  const UpdateContentEvent({required this.content, required this.images});

  @override
  List<Object?> get props => [content, images];
}

final class SavePostEvent extends PostEvent {
  final PostEntity? post;
  final String userId;
  final String content;
  final List<ImageFile> images;
  final String? sharedPostId;

  const SavePostEvent({
    required this.content,
    required this.images,
    required this.userId,
    this.post,
    this.sharedPostId,
  });

  @override
  List<Object?> get props => [userId, post, sharedPostId, content, images];
}

final class GetPostsEvent extends PostEvent {}

final class GetPostByIdEvent extends PostEvent {
  final String postId;
  const GetPostByIdEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

final class DeletePostById extends PostEvent {
  final String postId;
  const DeletePostById(this.postId);

  @override
  List<Object?> get props => [postId];
}

final class LikePostEvent extends PostEvent {
  final String postId;
  final Map<String, dynamic> data;

  const LikePostEvent(this.postId, this.data);

  @override
  List<Object?> get props => [postId, data];
}

final class UpdatePostEvent extends PostEvent {
  final String postId;
  final Map<String, dynamic> data;

  const UpdatePostEvent(this.postId, this.data);

  @override
  List<Object?> get props => [postId, data];
}

final class EditPostProgressEvent extends PostEvent {
  final String postId;
  const EditPostProgressEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}
