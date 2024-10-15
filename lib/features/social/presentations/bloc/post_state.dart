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
