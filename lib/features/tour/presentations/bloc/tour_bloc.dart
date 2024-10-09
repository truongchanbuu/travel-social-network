import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/domain/repositories/image_repository.dart';
import '../../data/models/tour.dart';
import '../../domain/entities/tour.dart';
import '../../domain/repositories/tour_repository.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  final TourRepository tourRepository;
  final ImageRepository imageRepository;
  static const basePath = '/tours';

  TourBloc({required this.tourRepository, required this.imageRepository})
      : super(TourInitial()) {
    on<InitializeNewTourEvent>(_onInitialNewTour);
    on<CreateTourEvent>(_onCreateTour);
    on<UpdateTourFieldEvent>(_onUpdateTourField);
    on<GetTourImagesEvent>(_onGetTourImages);
  }

  void _onInitialNewTour(event, emit) {
    emit(TourLoaded(TourEntity.defaultWithId()));
  }

  Future<void> _onCreateTour(
      CreateTourEvent event, Emitter<TourState> emit) async {
    try {
      List<String> imgUrls = [];

      for (var img in event.images) {
        String? imgUrl = await _onUploadImage(
            img, '$basePath/${event.tour.tourId}/${img.name}');

        if (imgUrl?.isNotEmpty ?? false) {
          imgUrls.add(imgUrl!);
        } else {
          emit(TourActionFailed(S.current.addImageFailure(img.name)));
        }
      }

      if (imgUrls.isNotEmpty) {
        final Tour tour =
            Tour.fromEntity(event.tour.copyWith(imageUrls: imgUrls));
        final dataState = await tourRepository.createTour(tour);

        if (dataState is DataFailure) {
          emit(TourActionFailed(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else if (dataState is DataSuccess) {
          emit(TourActionSucceed(tour.toEntity()));
        } else {
          emit(TourActionLoading());
        }
      }
    } catch (e) {
      emit(TourActionFailed('Tour Create Failed: $e'));
    }
  }

  Future<String?> _onUploadImage(ImageFile image, String path) async {
    try {
      var data = image.hasPath ? image.path : image.bytes;
      final dataState = await imageRepository.uploadImage(data, path);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'There some error ${dataState.error}');
        return null;
      }

      return dataState.data;
    } catch (e) {
      log(e.toString());
    }

    return null;
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
        value is List<String>) {
      return tour.copyWith(ticketIds: value);
    }
    // else if (fieldName == TourEntity.tourScheduleFieldName) {
    //   return tour.copyWith(tourSchedule: value);
    // }

    log('Tour may not be changed', level: 0);
    return tour;
  }

  Future<void> _onGetTourImages(GetTourImagesEvent event, emit) async {
    try {
      final dataState =
          await imageRepository.getFolderImages('$basePath/${event.tourId}');

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TourActionFailed(S.current.errorImage));
      } else if (dataState is DataSuccess) {
        emit(TourImagesLoaded(dataState.data!));
      } else {
        emit(TourActionLoading());
      }
    } catch (e) {
      emit(TourActionFailed('Get Images Failed: $e'));
    }
  }
}
