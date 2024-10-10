import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../domain/repositories/review_repository.dart';
import '../models/review.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final reviewCollection = firestore.collection('reviews');

  @override
  Future<DataState<List<Review>>> getAllTourReviews(String tourId) async {
    try {
      List<Review> reviews = [];
      final docQuery = reviewCollection.where('tourId', isEqualTo: tourId);
      final docSnaps = await docQuery.get();

      docSnaps.docs.map((doc) {
        if (doc.exists) {
          reviews.add(Review.fromJson(doc.data()));
        }
      });

      return DataSuccess(data: reviews);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<Review>> getReviewById(String reviewId) async {
    try {
      final docQuery = reviewCollection.doc(reviewId);
      final docSnap = await docQuery.get();

      if (!docSnap.exists) {
        return defaultDataFailure(S.current.notFound);
      }

      return DataSuccess(data: Review.fromJson(docSnap.data()!));
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }
}
