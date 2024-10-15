import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String reviewId;
  final String userId;
  final String tourId;
  final String content;
  final double rating;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> images;

  const ReviewEntity({
    required this.reviewId,
    required this.userId,
    required this.tourId,
    required this.content,
    required this.rating,
    required this.createdAt,
    this.updatedAt,
    required this.images,
  });

  @override
  List<Object?> get props {
    return [
      reviewId,
      userId,
      tourId,
      content,
      rating,
      createdAt,
      updatedAt,
      images,
    ];
  }

  static const String reviewIdFieldName = 'reviewId';
  static const String userIdFieldName = 'userId';
  static const String tourIdFieldName = 'tourId';
  static const String contentFieldName = 'content';
  static const String ratingFieldName = 'rating';
  static const String createdAtFieldName = 'createdAt';
  static const String updatedAtFieldName = 'updatedAt';
  static const String imagesFieldName = 'images';

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
}
