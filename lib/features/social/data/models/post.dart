import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/post.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends PostEntity {
  const Post({
    required super.postId,
    required super.content,
    required super.images,
    required super.userId,
  });

  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      content: content,
      images: images,
      userId: userId,
    );
  }

  factory Post.fromEntity(PostEntity entity) {
    return Post(
      postId: entity.postId,
      content: entity.content,
      images: entity.images,
      userId: entity.userId,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
