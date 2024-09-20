import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

import '../../domain/entities/review.dart';

part 'review.g.dart';

@JsonSerializable()
class Review extends ReviewEntity {
  const Review({
    required super.reviewId,
    required super.userId,
    required super.tourId,
    required super.content,
    required super.rating,
    required super.createdAt,
    super.updatedAt,
    required super.images,
  });

  Review copyWith({
    String? reviewId,
    String? userId,
    String? tourId,
    String? content,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? images,
  }) {
    return Review(
      reviewId: reviewId ?? this.reviewId,
      userId: userId ?? this.userId,
      tourId: tourId ?? this.tourId,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      reviewId: reviewId,
      userId: userId,
      tourId: tourId,
      content: content,
      rating: rating,
      createdAt: createdAt,
      updatedAt: updatedAt,
      images: images,
    );
  }

  factory Review.fromEntity(ReviewEntity entity) {
    return Review(
      reviewId: entity.reviewId,
      userId: entity.userId,
      tourId: entity.tourId,
      content: entity.content,
      rating: entity.rating,
      createdAt: entity.createdAt,
      images: entity.images,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "reviewId": reviewId,
      "userId": userId,
      "tourId": tourId,
      "content": content,
      "rating": rating,
      "createdAt": createdAt.toUtc().toIso8601String(),
      "updatedAt": updatedAt?.toUtc().toIso8601String(),
      "images": images,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewId: map["reviewId"],
      userId: map["userId"],
      tourId: map["tourId"],
      content: map["content"],
      rating: map["rating"]?.toDouble(),
      createdAt: DateTime.parse(map["createdAt"]).toLocal(),
      updatedAt: map["updatedAt"] != null
          ? DateTime.parse(map["updatedAt"]).toLocal()
          : null,
      images: List<String>.from(map["images"]),
    );
  }

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  String toString() {
    return "Review(reviewId: $reviewId, userId: $userId, tourId: $tourId, content: $content, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt, images: $images)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Review &&
        other.reviewId == reviewId &&
        other.userId == userId &&
        other.tourId == tourId &&
        other.content == content &&
        other.rating == rating &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return reviewId.hashCode ^
        userId.hashCode ^
        tourId.hashCode ^
        content.hashCode ^
        rating.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        images.hashCode;
  }
}
