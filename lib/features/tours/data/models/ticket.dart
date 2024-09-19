import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/ticket.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket extends TicketEntity {
  const Ticket({
    required super.ticketId,
    required super.tourId,
    required super.ticketTypeId,
    required super.customerId,
    required super.purchasedDate,
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "ticketId": ticketId,
      "tourId": tourId,
      "ticketTypeId": ticketTypeId,
      "customerId": customerId,
      "purchasedDate": purchasedDate.toUtc().toIso8601String(),
      "ticketPrice": ticketPrice,
      "discount": discount,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      ticketId: map["ticketId"],
      tourId: map["tourId"],
      ticketTypeId: map["ticketTypeId"],
      customerId: map["customerId"],
      purchasedDate: DateTime.parse(map["purchasedDate"]).toLocal(),
      ticketPrice: map["ticketPrice"],
      discount: map["discount"]?.toDouble(),
    );
  }

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  String toString() {
    return "Ticket(ticketId: $ticketId, tourId: $tourId, ticketTypeId: $ticketTypeId, customerId: $customerId, purchasedDate: $purchasedDate, ticketPrice: $ticketPrice, discount: $discount)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ticket &&
        other.ticketId == ticketId &&
        other.tourId == tourId &&
        other.ticketTypeId == ticketTypeId &&
        other.customerId == customerId &&
        other.purchasedDate == purchasedDate &&
        other.ticketPrice == ticketPrice &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return ticketId.hashCode ^
        tourId.hashCode ^
        ticketTypeId.hashCode ^
        customerId.hashCode ^
        purchasedDate.hashCode ^
        ticketPrice.hashCode ^
        discount.hashCode;
  }
}
