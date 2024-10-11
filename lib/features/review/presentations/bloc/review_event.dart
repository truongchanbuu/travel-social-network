part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

final class GetAllTourReviewsEvent extends ReviewEvent {
  final String tourId;
  const GetAllTourReviewsEvent(this.tourId);

  @override
  List<Object> get props => [tourId];
}

final class GetReviewByIdEvent extends ReviewEvent {
  final String reviewId;
  const GetReviewByIdEvent(this.reviewId);

  @override
  List<Object> get props => [reviewId];
}

final class CreateReviewEvent extends ReviewEvent {
  final String tourId;
  final String userId;
  final String content;
  final List<ImageFile> images;
  final double rating;

  const CreateReviewEvent({
    required this.tourId,
    required this.userId,
    required this.content,
    required this.images,
    required this.rating,
  });

  @override
  List<Object> get props => [tourId, content, images, rating];
}
