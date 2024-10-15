import '../../../../cores/resources/data_state.dart';
import '../../data/models/review.dart';

abstract interface class ReviewRepository {
  Future<DataState<Review>> getReviewById(String reviewId);
  Stream<DataState<List<Review>>> getAllTourReviews(String tourId);
  Future<DataState<Review>> createReview(Review review);
  Future<DataState<void>> deleteReviewById(String reviewId);
}
