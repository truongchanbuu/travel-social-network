import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../../cores/enums/booking_status.dart';

class TourEntity extends Equatable {
  final String tourId;
  final String tourName;
  final String tourDescription;
  final num tourPrice;
  final String departure;
  final String destination;
  final int duration;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int maxGroupSize;
  final int currentGroupSize;
  final double rating;
  final BookingStatus bookingStatus;
  final DateTime createdAt = DateTime.now();
  final DateTime? updatedAt;

  TourEntity({
    required this.tourId,
    required this.tourName,
    required this.tourDescription,
    required this.tourPrice,
    required this.departure,
    required this.destination,
    required this.duration,
    required this.startDateTime,
    required this.endDateTime,
    required this.maxGroupSize,
    required this.currentGroupSize,
    required this.rating,
    required this.bookingStatus,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      tourId,
      tourName,
      tourDescription,
      tourPrice,
      departure,
      destination,
      duration,
      startDateTime,
      endDateTime,
      maxGroupSize,
      currentGroupSize,
      rating,
      bookingStatus,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'TourEntity(tourId: $tourId, tourName: $tourName, tourDescription: $tourDescription, tourPrice: $tourPrice, departure: $departure, destination: $destination, duration: $duration, startDateTime: $startDateTime, endDateTime: $endDateTime, maxGroupSize: $maxGroupSize, currentGroupSize: $currentGroupSize, rating: $rating, bookingStatus: $bookingStatus, updatedAt: $updatedAt)';
  }
}
