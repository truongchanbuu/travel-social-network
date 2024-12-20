import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../cores/utils/image_utils.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/tour.dart';
import '../../domain/entities/tour.dart';
import '../../domain/repositories/tour_repository.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  final TourRepository tourRepository;
  static const basePath = '/tours';

  TourBloc(this.tourRepository) : super(TourInitial()) {
    on<InitializeNewTourEvent>(_onInitialNewTour);
    on<CreateTourEvent>(_onCreateTour);
    on<GetTourByIdEvent>(_onGetTourById);
    on<UpdateTourFieldEvent>(_onUpdateTourField);
    on<GetTourImagesEvent>(_onGetTourImages);
    on<GetTopRatingToursEvent>(_onGetTopRatingTours);
    on<UpdateTourRatingEvent>(_onUpdateTourRating);
    on<GetToursByUserIdEvent>(_onGetUserTours);
    on<DeleteTourEvent>(_onDeleteTour);
  }

  void _onInitialNewTour(event, emit) {
    emit(TourLoaded(TourEntity.withId));
  }

  Future<void> _onGetTourById(GetTourByIdEvent event, emit) async {
    try {
      final dataState = await tourRepository.getTourById(event.tourId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TourActionFailed(S.current.dataStateFailure));
      } else {
        emit(TourLoaded(dataState.data!.toEntity()));
      }
    } catch (e) {
      log(e.toString());
      emit(TourActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onCreateTour(
      CreateTourEvent event, Emitter<TourState> emit) async {
    try {
      emit(TourActionLoading());
      List<String> imgUrls = [];

      for (var img in event.images) {
        String? imgUrl = await ImageUtils.uploadImage(
            img, '$basePath/${event.tour.tourId}/${img.name}');

        if (imgUrl?.isNotEmpty ?? false) {
          imgUrls.add(imgUrl!);
        } else {
          emit(TourActionFailed(S.current.addImageFailure(img.name)));
        }
      }

      if (imgUrls.isNotEmpty) {
        final Tour tour = Tour.fromEntity(
          event.tour.copyWith(
            imageUrls: imgUrls,
            tourId: event.tour.tourId.isEmpty
                ? 'TOUR-${const Uuid().v4()}'
                : event.tour.tourId,
            createdBy: event.createdBy,
          ),
        );

        final dataState = await tourRepository.createTour(tour);

        if (dataState is DataFailure) {
          log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
          emit(TourActionFailed(S.current.dataStateFailure));
        } else {
          emit(TourActionSuccess(tour.toEntity()));
        }
      }
    } catch (e) {
      log(e.toString());
      emit(TourActionFailed(S.current.dataStateFailure));
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
    if (fieldName == TourEntity.tourNameFieldName) {
      return tour.copyWith(tourName: value.toString());
    } else if (fieldName == TourEntity.tourDescriptionFieldName) {
      return tour.copyWith(tourDescription: value.toString());
    } else if (fieldName == TourEntity.durationFieldName) {
      return tour.copyWith(duration: value.toString());
    } else if (fieldName == TourEntity.departureFieldName) {
      return tour.copyWith(departure: value.toString());
    } else if (fieldName == TourEntity.destinationFieldName) {
      return tour.copyWith(destination: value.toString());
    } else if (fieldName == TourEntity.tourScheduleFieldName) {
      return tour.copyWith(tourSchedule: value.toString());
    } else if (fieldName == TourEntity.additionalInfoFiledName) {
      return tour.copyWith(additionalInfo: value.toString());
    } else if (fieldName == TourEntity.ticketIdsFieldName &&
        value is List<String>) {
      return tour.copyWith(ticketIds: value);
    } else {
      log('Tour may not be changed');
    }

    return tour;
  }

  Future<void> _onGetTourImages(GetTourImagesEvent event, emit) async {
    try {
      emit(TourActionLoading());
      final images =
          await ImageUtils.getFolderImages('$basePath/${event.tourId}');

      if (images != null) {
        emit(TourImagesLoaded(images));
      } else {
        emit(TourActionFailed(S.current.errorImage));
      }
    } catch (e) {
      log(e.toString());
      emit(TourActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onGetTopRatingTours(
      GetTopRatingToursEvent event, Emitter<TourState> emit) async {
    try {
      final dataState = await tourRepository.getTopRatingTours();

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TourActionFailed(S.current.dataStateFailure));
      } else {
        emit(ListOfToursLoaded(
            dataState.data!.map((tour) => tour.toEntity()).toList()));
      }
    } catch (e) {
      log(e.toString());
      emit(TourActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onUpdateTourRating(
      UpdateTourRatingEvent event, Emitter<TourState> emit) async {
    try {
      final dataState = await tourRepository.updateTour(event.tourId, {
        TourEntity.ratingFieldName: event.rating,
      });

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TourActionFailed(S.current.dataStateFailure));
      } else {
        emit(TourActionSuccess(dataState.data!.toEntity()));
      }
    } catch (e) {
      log(e.toString());
      emit(TourActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onGetUserTours(
      GetToursByUserIdEvent event, Emitter<TourState> emit) async {
    try {
      final dataState = await tourRepository.getTourByUserId(event.userId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TourActionFailed(S.current.dataStateFailure));
      } else {
        emit(
          ListOfToursLoaded(
              dataState.data?.map((tour) => tour.toEntity()).toList() ?? []),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(TourActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onDeleteTour(
      DeleteTourEvent event, Emitter<TourState> emit) async {
    try {
      final dataState = await tourRepository.deleteTour(event.tourId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TourActionFailed(S.current.dataStateFailure));
      } else {
        emit(TourDeleted());
      }
    } catch (e) {
      log(e.toString());
      emit(TourActionFailed(S.current.dataStateFailure));
    }
  }
}
