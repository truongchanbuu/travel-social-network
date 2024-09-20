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
}
