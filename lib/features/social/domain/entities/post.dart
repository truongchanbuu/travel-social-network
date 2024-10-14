import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String postId;
  final String content;
  final List<String> images;
  final String userId;

  const PostEntity({
    required this.postId,
    required this.content,
    required this.images,
    required this.userId,
  });

  PostEntity copyWith({
    String? postId,
    String? content,
    List<String>? images,
    String? userId,
  }) {
    return PostEntity(
      postId: postId ?? this.postId,
      content: content ?? this.content,
      images: images ?? this.images,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [postId, content, images];

  static const postIdFieldName = "postId";
  static const contentFieldName = "content";
  static const imagesFieldName = "images";
}
