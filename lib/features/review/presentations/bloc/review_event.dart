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
  final ReviewEntity review;
  final List<ImageFile> images;

  const CreateReviewEvent(this.review, this.images);

  @override
  List<Object> get props => [review, images];
}

final class DeleteReviewEvent extends ReviewEvent {
  final String reviewId;
  const DeleteReviewEvent(this.reviewId);

  @override
  List<Object> get props => [reviewId];
}

final class UpdateReviewFieldEvent extends ReviewEvent {
  final String fieldName;
  final dynamic value;

  const UpdateReviewFieldEvent(this.fieldName, this.value);

  @override
  List<Object> get props => [fieldName, value];
}

final class InitializeNewReviewEvent extends ReviewEvent {
  final String tourId;
  final String userId;

  const InitializeNewReviewEvent({required this.tourId, required this.userId});

  @override
  List<Object> get props => [userId, tourId];
}

final class UploadImageEvent extends ReviewEvent {
  final List<ImageFile> images;
  const UploadImageEvent(this.images);

  @override
  List<Object> get props => [images];
}
