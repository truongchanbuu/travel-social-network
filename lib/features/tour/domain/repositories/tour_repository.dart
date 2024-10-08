import '../../../../cores/resources/data_state.dart';
import '../../data/models/tour.dart';

abstract interface class TourRepository {
  Future<DataState<Tour>> createTour();
}
