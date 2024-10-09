import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_network/cores/resources/data_state.dart';

import '../../../../cores/constants/constants.dart';
import '../../domain/repositories/tour_repository.dart';
import '../models/tour.dart';

class TourRepositoryImpl implements TourRepository {
  final tourCollection = firestore.collection('tours');

  @override
  Future<DataState<Tour>> createTour(Tour tour) async {
    try {
      await tourCollection.doc(tour.tourId).set(tour.toJson());
      return DataSuccess(data: tour);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<Tour>>> getTopRatingTours({int limit = 20}) async {
    try {
      final docQuery =
          tourCollection.orderBy('rating', descending: true).limit(limit);
      final docSnaps = await docQuery.get();
      List<Tour> tours = docSnaps.docs
          .map((doc) => Tour.fromJson(doc as Map<String, dynamic>))
          .toList();
      return DataSuccess(data: tours);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }
}
