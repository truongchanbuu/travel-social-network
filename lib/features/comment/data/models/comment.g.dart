// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      commentId: json['commentId'] as String,
      content: json['content'] as String,
      likedUsers: (json['likedUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      postId: json['postId'] as String,
      parentCommentId: json['parentCommentId'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'commentId': instance.commentId,
      'content': instance.content,
      'likedUsers': instance.likedUsers,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'postId': instance.postId,
      'parentCommentId': instance.parentCommentId,
    };
