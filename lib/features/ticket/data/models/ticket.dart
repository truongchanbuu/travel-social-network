import 'package:json_annotation/json_annotation.dart';

import '../../../../cores/enums/ticket_category.dart';
import '../../domain/entities/ticket.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket extends TicketEntity {
  const Ticket({
    required super.ticketId,
    required super.category,
    required super.tourId,
    required super.ticketTypeId,
    required super.customerId,
    required super.purchasedDate,
    required super.quantity,
    required super.ticketPrice,
    required super.discount,
  });

  Ticket copyWith({
    String? ticketId,
    String? tourId,
    String? ticketTypeId,
    String? customerId,
    DateTime? purchasedDate,
    num? ticketPrice,
    int? quantity,
    TicketCategory? category,
    double? discount,
  }) {
    return Ticket(
      ticketId: ticketId ?? this.ticketId,
      tourId: tourId ?? this.tourId,
      ticketTypeId: ticketTypeId ?? this.ticketTypeId,
      customerId: customerId ?? this.customerId,
      purchasedDate: purchasedDate ?? this.purchasedDate,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      discount: discount ?? this.discount,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }

  TicketEntity toEntity() {
    return TicketEntity(
      ticketId: ticketId,
      tourId: tourId,
      ticketTypeId: ticketTypeId,
      customerId: customerId,
      purchasedDate: purchasedDate,
      ticketPrice: ticketPrice,
      quantity: quantity,
      discount: discount,
      category: category,
    );
  }

  factory Ticket.fromEntity(TicketEntity entity) {
    return Ticket(
      ticketId: entity.ticketId,
      tourId: entity.tourId,
      ticketTypeId: entity.ticketTypeId,
      customerId: entity.customerId,
      purchasedDate: entity.purchasedDate,
      ticketPrice: entity.ticketPrice,
      discount: entity.discount,
      quantity: entity.quantity,
      category: entity.category,
    );
  }

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
