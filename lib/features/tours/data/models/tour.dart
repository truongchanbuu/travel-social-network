import 'dart:convert';

import '../../../../cores/enums/booking_status.dart';
import '../../domain/entities/tour.dart';

class Tour extends TourEntity {
  Tour({
    required super.tourId,
    required super.tourName,
    required super.tourDescription,
    required super.tourPrice,
    required super.departure,
    required super.destination,
    required super.duration,
    required super.startDateTime,
    required super.endDateTime,
    required super.maxGroupSize,
    required super.currentGroupSize,
    required super.rating,
    required super.bookingStatus,
    super.updatedAt,
  });

  TourEntity toEntity() {
    return TourEntity(
      tourId: tourId,
      tourName: tourName,
      tourDescription: tourDescription,
      tourPrice: tourPrice,
      departure: departure,
      destination: destination,
      duration: duration,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      maxGroupSize: maxGroupSize,
      currentGroupSize: currentGroupSize,
      rating: rating,
      bookingStatus: bookingStatus,
      updatedAt: updatedAt,
    );
  }

  factory Tour.fromEntity(TourEntity entity) {
    return Tour(
      tourId: entity.tourId,
      tourName: entity.tourName,
      tourDescription: entity.tourDescription,
      tourPrice: entity.tourPrice,
      departure: entity.departure,
      destination: entity.destination,
      duration: entity.duration,
      startDateTime: entity.startDateTime,
      endDateTime: entity.endDateTime,
      maxGroupSize: entity.maxGroupSize,
      currentGroupSize: entity.currentGroupSize,
      rating: entity.rating,
      bookingStatus: entity.bookingStatus,
      updatedAt: entity.updatedAt,
    );
  }

  Tour copyWith({
    String? tourId,
    String? tourName,
    String? tourDescription,
    num? tourPrice,
    String? departure,
    String? destination,
    int? duration,
    DateTime? startDateTime,
    DateTime? endDateTime,
    int? maxGroupSize,
    int? currentGroupSize,
    double? rating,
    BookingStatus? bookingStatus,
    DateTime? updatedAt,
  }) {
    return Tour(
      tourId: tourId ?? this.tourId,
      tourName: tourName ?? this.tourName,
      tourDescription: tourDescription ?? this.tourDescription,
      tourPrice: tourPrice ?? this.tourPrice,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      duration: duration ?? this.duration,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      maxGroupSize: maxGroupSize ?? this.maxGroupSize,
      currentGroupSize: currentGroupSize ?? this.currentGroupSize,
      rating: rating ?? this.rating,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tourId': tourId,
      'tourName': tourName,
      'tourDescription': tourDescription,
      'tourPrice': tourPrice,
      'departure': departure,
      'destination': destination,
      'duration': duration,
      'startDateTime': startDateTime.millisecondsSinceEpoch,
      'endDateTime': endDateTime.millisecondsSinceEpoch,
      'maxGroupSize': maxGroupSize,
      'currentGroupSize': currentGroupSize,
      'rating': rating,
      'bookingStatus': bookingStatus,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Tour.fromMap(Map<String, dynamic> map) {
    return Tour(
      tourId: map['tourId'] ?? '',
      tourName: map['tourName'] ?? '',
      tourDescription: map['tourDescription'] ?? '',
      tourPrice: map['tourPrice'] ?? 0,
      departure: map['departure'] ?? '',
      destination: map['destination'] ?? '',
      duration: map['duration']?.toInt() ?? 0,
      startDateTime: DateTime.fromMillisecondsSinceEpoch(map['startDateTime']),
      endDateTime: DateTime.fromMillisecondsSinceEpoch(map['endDateTime']),
      maxGroupSize: map['maxGroupSize']?.toInt() ?? 0,
      currentGroupSize: map['currentGroupSize']?.toInt() ?? 0,
      rating: map['rating']?.toDouble() ?? 0.0,
      bookingStatus: BookingStatus.values.firstWhere(
        (status) => status.toString().split('.').last == map['bookingStatus'],
        orElse: () => BookingStatus.unavailable,
      ),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tour.fromJson(String source) => Tour.fromMap(json.decode(source));
}
