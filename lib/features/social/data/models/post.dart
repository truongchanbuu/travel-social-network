import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/post.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends PostEntity {
  const Post({
    required super.postId,
    required super.content,
    required super.images,
    required super.likedUsers,
    required super.userId,
    required super.createdAt,
    super.updatedAt,
  });

  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      content: content,
      images: images,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      likedUsers: likedUsers,
    );
  }

  factory Post.fromEntity(PostEntity entity) {
    return Post(
      postId: entity.postId,
      content: entity.content,
      images: entity.images,
      likedUsers: entity.likedUsers,
      userId: entity.userId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
