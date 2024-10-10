import '../../../../cores/resources/data_state.dart';
import '../../data/models/tour.dart';

abstract interface class TourRepository {
  Future<DataState<Tour>> createTour(Tour tour);
  Future<DataState<List<Tour>>> getTopRatingTours({int limit = 20});
  Future<DataState<Tour>> getTourById(String tourId);
}
