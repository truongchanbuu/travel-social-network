import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';
import '../models/review.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final reviewCollection = firestore.collection('reviews');

  @override
  Stream<DataState<List<Review>>> getAllTourReviews(String tourId) async* {
    try {
      yield* reviewCollection
          .where(ReviewEntity.tourIdFieldName, isEqualTo: tourId)
          .snapshots()
          .map((snapshot) {
        final reviews =
            snapshot.docs.map((doc) => Review.fromJson(doc.data())).toList();

        return DataSuccess(data: reviews);
      }).handleError((e) {
        if (e is FirebaseException) {
          return handleFirebaseException(e);
        } else {
          return defaultDataFailure(e.toString());
        }
      });
    } catch (e) {
      Stream.value(defaultDataFailure(e.toString()));
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

  @override
  Future<DataState<Review>> createReview(Review review) async {
    try {
      await reviewCollection.doc(review.reviewId).set(review.toJson());
      return DataSuccess(data: review);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<void>> deleteReviewById(String reviewId) async {
    try {
      await reviewCollection.doc(reviewId).delete();
      return const DataSuccess();
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }
}
