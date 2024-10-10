part of 'review_bloc.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}

final class ReviewActionLoading extends ReviewState {}

final class ReviewActionFailure extends ReviewState {
  final String message;
  const ReviewActionFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ReviewActionSuccess extends ReviewState {
  final ReviewEntity review;
  const ReviewActionSuccess(this.review);

  @override
  List<Object> get props => [review];
}

final class ReviewLoaded extends ReviewState {
  final ReviewEntity review;
  const ReviewLoaded(this.review);

  @override
  List<Object> get props => [review];
}

final class ListOfReviewLoaded extends ReviewState {
  final List<ReviewEntity> reviews;
  const ListOfReviewLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}
