import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/tour.dart';
import '../../domain/repositories/tour_repository.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  final TourRepository _tourRepository;

  TourBloc(this._tourRepository)
      : super(TourLoaded(TourEntity.defaultWithId())) {
    on<UpdateTourFieldEvent>(_onUpdateTourField);
  }

  void _onUpdateTourField(UpdateTourFieldEvent event, Emitter<TourState> emit) {
    if (state is TourLoaded) {
      final TourEntity currentTour = (state as TourLoaded).tour;
      final TourEntity updatedTour =
          _updateTourField(currentTour, event.fieldName, event.value);
      emit(TourLoaded(updatedTour));
    }
  }

  TourEntity _updateTourField(
      TourEntity tour, String fieldName, dynamic value) {
    switch (fieldName) {
      case TourEntity.tourNameFieldName:
        return tour.copyWith(tourName: value as String);
      case TourEntity.tourDescriptionFieldName:
        return tour.copyWith(tourDescription: value as String);
      case TourEntity.durationFieldName:
        return tour.copyWith(duration: value as String);
      case TourEntity.departureFieldName:
        return tour.copyWith(departure: value as String);
      case TourEntity.destinationFieldName:
        return tour.copyWith(destination: value as String);
      // case TourEntity.tourScheduleFieldName:
      //   return tour.copyWith(tourSchedule: value);
      default:
        return tour;
    }
  }
}
