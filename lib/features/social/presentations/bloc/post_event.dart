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
