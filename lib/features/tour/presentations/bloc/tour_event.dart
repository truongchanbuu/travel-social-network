part of 'tour_bloc.dart';

sealed class TourEvent extends Equatable {
  const TourEvent();

  @override
  List<Object> get props => [];
}

final class InitializeNewTourEvent extends TourEvent {}

final class CreateTourEvent extends TourEvent {
  final String createdBy;
  final TourEntity tour;
  final List<ImageFile> images;

  const CreateTourEvent({
    required this.tour,
    required this.images,
    required this.createdBy,
  });

  @override
  List<Object> get props => [tour, images, createdBy];
}

final class GetTourByIdEvent extends TourEvent {
  final String tourId;
  const GetTourByIdEvent(this.tourId);

  @override
  List<Object> get props => [tourId];
}

final class UpdateTourFieldEvent extends TourEvent {
  final String fieldName;
  final dynamic value;

  const UpdateTourFieldEvent(this.fieldName, this.value);

  @override
  List<Object> get props => [fieldName, value];
}

final class GetToursByUserIdEvent extends TourEvent {
  final String userId;
  const GetToursByUserIdEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

final class GetTourImagesEvent extends TourEvent {
  final String tourId;
  const GetTourImagesEvent(this.tourId);

  @override
  List<Object> get props => [tourId];
}

final class GetTopRatingToursEvent extends TourEvent {}

final class UpdateTourRatingEvent extends TourEvent {
  final String tourId;
  final double rating;
  const UpdateTourRatingEvent(this.tourId, this.rating);

  @override
  List<Object> get props => [tourId, rating];
}
