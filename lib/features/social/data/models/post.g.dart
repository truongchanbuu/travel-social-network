// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postId: json['postId'] as String,
      content: json['content'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      likedUsers: (json['likedUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'content': instance.content,
      'images': instance.images,
      'likedUsers': instance.likedUsers,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
