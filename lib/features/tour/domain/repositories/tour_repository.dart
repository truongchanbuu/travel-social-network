import '../../../../cores/resources/data_state.dart';
import '../../data/models/tour.dart';

abstract interface class TourRepository {
  Future<DataState<Tour>> createTour(Tour tour);
  Future<DataState<List<Tour>>> getTopRatingTours({int limit = 20});
  Future<DataState<Tour>> getTourById(String tourId);
  Future<DataState<List<Tour>>> getTourByUserId(String userId);
  Future<DataState<Tour>> updateTour(String tourId, Map<String, dynamic> data);
  Future<DataState<Tour>> deleteTour(String tourId);
}
