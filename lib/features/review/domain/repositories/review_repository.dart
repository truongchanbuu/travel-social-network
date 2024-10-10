import '../../../../cores/resources/data_state.dart';
import '../../data/models/review.dart';

abstract interface class ReviewRepository {
  Future<DataState<Review>> getReviewById(String reviewId);
  Future<DataState<List<Review>>> getAllTourReviews(String tourId);
}
