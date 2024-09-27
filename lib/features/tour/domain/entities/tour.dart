import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../ticket/domain/entities/ticket_type.dart';
import 'tour_schedule.dart';

class TourEntity extends Equatable {
  final String tourId;
  final String tourName;
  final String tourDescription;
  final String createdBy;
  final List<TicketTypeEntity> tickets;
  final List<String> imageUrls;
  final String departure;
  final String destination;
  final int duration;
  final double rating;
  final TourScheduleEntity? tourSchedule;

  const TourEntity({
    required this.tourId,
    required this.tourName,
    required this.tourDescription,
    required this.createdBy,
    required this.tickets,
    required this.imageUrls,
    required this.departure,
    required this.destination,
    required this.duration,
    required this.rating,
    this.tourSchedule,
  });

  TourEntity.defaultWithId({
    this.tourName = '',
    this.tourDescription = '',
    this.createdBy = '',
    this.tickets = const <TicketTypeEntity>[],
    this.imageUrls = const <String>[],
    this.departure = '',
    this.destination = '',
    this.duration = 0,
    this.rating = 0.0,
    this.tourSchedule,
  }) : tourId = 'TOUR-${const Uuid().v4()}';

  @override
  List<Object?> get props {
    return [
      tourId,
      tourName,
      tourDescription,
      createdBy,
      tickets,
      imageUrls,
      departure,
      destination,
      duration,
      rating,
      tourSchedule,
    ];
  }
}
