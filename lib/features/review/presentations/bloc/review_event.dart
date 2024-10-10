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
