import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../ticket/domain/entities/ticket_type.dart';
import '../../domain/entities/tour.dart';
import '../../domain/repositories/tour_repository.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  final TourRepository tourRepository;

  TourBloc(this.tourRepository)
      : super(TourLoaded(TourEntity.defaultWithId())) {
    on<CreateTourEvent>(_onCreateTour);
    on<UpdateTourFieldEvent>(_onUpdateTourField);
  }

  Future<void> _onCreateTour(
      CreateTourEvent event, Emitter<TourState> emit) async {
    try {
      List<String> uploadedUrl = ...
      final dataState = await tourRepository.createTour();

      if (dataState is DataFailure) {
        emit(TourActionFailed(
            dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}'));
      } else if (dataState is DataSuccess) {
        emit((dataState.data!.map((ticket) => ticket.toEntity()).toList()));
      } else {
        emit(TourActionLoading());
      }
    } catch (e) {
      emit(TourActionFailed('List of Tickets Created Failure: $e'));
    }
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
    if (value is String) {
      if (fieldName == TourEntity.tourNameFieldName) {
        return tour.copyWith(tourName: value);
      } else if (fieldName == TourEntity.tourDescriptionFieldName) {
        return tour.copyWith(tourDescription: value);
      } else if (fieldName == TourEntity.durationFieldName) {
        return tour.copyWith(duration: value);
      } else if (fieldName == TourEntity.departureFieldName) {
        return tour.copyWith(departure: value);
      } else if (fieldName == TourEntity.destinationFieldName) {
        return tour.copyWith(destination: value);
      }
    } else if (fieldName == TourEntity.ticketsFieldName &&
        value is List<TicketTypeEntity>) {
      return tour.copyWith(tickets: value);
    }
    // else if (fieldName == TourEntity.tourScheduleFieldName) {
    //   return tour.copyWith(tourSchedule: value);
    // }

    log('Tour may not be changed', level: 0);
    return tour;
  }
}
