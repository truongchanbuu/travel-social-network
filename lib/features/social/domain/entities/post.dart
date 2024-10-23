import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String postId;
  final String content;
  final List<String> images;
  final List<String> likedUsers;
  final String userId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? refPostId;
  final List<String> sharedBy;

  const PostEntity({
    required this.postId,
    required this.content,
    required this.images,
    required this.userId,
    required this.likedUsers,
    required this.createdAt,
    required this.sharedBy,
    required this.refPostId,
    this.updatedAt,
  });

  PostEntity copyWith({
    String? postId,
    String? content,
    List<String>? images,
    List<String>? likedUsers,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? sharedBy,
    String? refPostId,
  }) {
    return PostEntity(
      postId: postId ?? this.postId,
      content: content ?? this.content,
      images: images ?? this.images,
      likedUsers: likedUsers ?? this.likedUsers,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sharedBy: sharedBy ?? this.sharedBy,
      refPostId: refPostId ?? this.refPostId,
    );
  }

  @override
  List<Object?> get props => [
        postId,
        content,
        images,
        likedUsers,
        createdAt,
        updatedAt,
        sharedBy,
        refPostId,
      ];

  static const postIdFieldName = "postId";
  static const contentFieldName = "content";
  static const imagesFieldName = "images";
  static const likedUsersFieldName = "likedUsers";
  static const createdAtFieldName = "createdAt";
  static const updatedAtFieldName = "updatedAt";
  static const sharedByFieldName = "sharedBy";
  static const refPostIdFieldName = "refPostId";
}
