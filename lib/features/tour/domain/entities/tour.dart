import 'package:equatable/equatable.dart';
import 'package:travel_social_network/features/ticket/domain/entities/ticket_type.dart';

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
  final DateTime startedDate;
  final DateTime endDate;
  final double rating;

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
    required this.startedDate,
    required this.endDate,
    required this.rating,
  });

  @override
  List<Object> get props {
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
      startedDate,
      endDate,
      rating,
    ];
  }
}
