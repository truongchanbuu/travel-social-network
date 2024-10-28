import 'package:equatable/equatable.dart';

class TourEntity extends Equatable {
  final String tourId;
  final String tourName;
  final String tourDescription;
  final String createdBy;
  final List<String> ticketIds;
  final List<String> imageUrls;
  final String departure;
  final String destination;
  final String duration;
  final double rating;
  final String? additionalInfo;
  // final TourScheduleEntity? tourSchedule;
  final String? tourSchedule;

  const TourEntity({
    required this.tourId,
    required this.tourName,
    required this.tourDescription,
    required this.createdBy,
    required this.ticketIds,
    required this.imageUrls,
    required this.departure,
    required this.destination,
    required this.duration,
    required this.rating,
    this.additionalInfo,
    this.tourSchedule,
  });

  static const empty = TourEntity(
    tourId: '',
    tourName: '',
    tourDescription: '',
    createdBy: '',
    ticketIds: <String>[],
    imageUrls: <String>[],
    departure: '',
    destination: '',
    duration: '',
    rating: 0.0,
    additionalInfo: '',
    tourSchedule: '',
  );

  TourEntity copyWith({
    String? tourId,
    String? tourName,
    String? tourDescription,
    String? createdBy,
    List<String>? ticketIds,
    List<String>? imageUrls,
    String? departure,
    String? destination,
    String? duration,
    double? rating,
    String? tourSchedule,
    String? additionalInfo,
  }) {
    return TourEntity(
      tourId: tourId ?? this.tourId,
      tourName: tourName ?? this.tourName,
      tourDescription: tourDescription ?? this.tourDescription,
      createdBy: createdBy ?? this.createdBy,
      ticketIds: ticketIds ?? this.ticketIds,
      imageUrls: imageUrls ?? this.imageUrls,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      tourSchedule: tourSchedule ?? this.tourSchedule,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  @override
  List<Object?> get props {
    return [
      tourId,
      tourName,
      tourDescription,
      createdBy,
      ticketIds,
      imageUrls,
      departure,
      destination,
      duration,
      rating,
      tourSchedule,
      additionalInfo,
    ];
  }

  static const String tourIdFieldName = "tourId";
  static const String tourNameFieldName = "tourName";
  static const String tourDescriptionFieldName = "tourDescription";
  static const String createdByFieldName = "createdBy";
  static const String ticketIdsFieldName = "ticketIds";
  static const String imageUrlsFieldName = "imageUrls";
  static const String departureFieldName = "departure";
  static const String destinationFieldName = "destination";
  static const String durationFieldName = "duration";
  static const String ratingFieldName = "rating";
  static const String tourScheduleFieldName = "tourSchedule";
  static const String additionalInfoFiledName = "additionalInfo";
}
