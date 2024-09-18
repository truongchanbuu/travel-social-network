import 'dart:convert';

import '../../domain/entities/review.dart';

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

  ReviewEntity copyWith({
    String? reviewId,
    String? userId,
    String? tourId,
    String? content,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? images,
  }) {
    return ReviewEntity(
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

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'userId': userId,
      'tourId': tourId,
      'content': content,
      'rating': rating,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'images': images,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewId: map['reviewId'] ?? '',
      userId: map['userId'] ?? '',
      tourId: map['tourId'] ?? '',
      content: map['content'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      images: List<String>.from(map['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(reviewId: $reviewId, userId: $userId, tourId: $tourId, content: $content, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt, images: $images)';
  }
}
