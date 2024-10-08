import 'package:travel_social_network/cores/resources/data_state.dart';
import 'package:travel_social_network/features/tour/data/models/tour.dart';

import '../../../../cores/constants/constants.dart';
import '../../domain/repositories/tour_repository.dart';

class TourRepositoryImpl implements TourRepository {
  final tourCollection = firestore.collection('tours');

  @override
  Future<DataState<Tour>> createTour() {
    // TODO: implement createTour
    throw UnimplementedError();
  }
}
