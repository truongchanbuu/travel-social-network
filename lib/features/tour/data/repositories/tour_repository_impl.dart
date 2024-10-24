import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/tour.dart';
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
      List<Tour> tours = [];
      final docQuery = tourCollection
          .orderBy(TourEntity.ratingFieldName, descending: true)
          .limit(limit);
      final docSnaps = await docQuery.get();

      for (var doc in docSnaps.docs) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data();

          for (var field in [
            TourEntity.imageUrlsFieldName,
            TourEntity.tourScheduleFieldName,
            TourEntity.ticketIdsFieldName
          ]) {
            if (data[field] == null) {
              data[field] = [];
            }
          }

          Tour tour = Tour.fromJson(data);
          tours.add(tour);
        }
      }

      return DataSuccess(data: tours);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<Tour>> getTourById(String tourId) async {
    try {
      final docQuery = tourCollection.doc(tourId);
      final docSnap = await docQuery.get();

      if (!docSnap.exists) {
        return defaultDataFailure(S.current.notFound);
      }

      return DataSuccess(data: Tour.fromJson(docSnap.data()!));
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<Tour>> updateTour(
      String tourId, Map<String, dynamic> data) async {
    try {
      final docQuery = tourCollection.doc(tourId);
      docQuery.update(data);

      final docSnap = await docQuery.get();

      if (docSnap.exists) {
        return DataSuccess(data: Tour.fromJson(docSnap.data()!));
      } else {
        return defaultDataFailure(S.current.notFound);
      }
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<Tour>>> getTourByUserId(String userId) async {
    try {
      List<Tour> tours = [];
      final docQuery = tourCollection.where(TourEntity.createdByFieldName,
          isEqualTo: userId);
      final docSnaps = await docQuery.get();

      for (var doc in docSnaps.docs) {
        final tour = Tour.fromJson(doc.data());
        tours.add(tour);
      }

      return DataSuccess(data: tours);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }
}
