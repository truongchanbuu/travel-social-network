import 'package:json_annotation/json_annotation.dart';

import '../../../../cores/enums/ticket_category.dart';
import '../../../../cores/utils/enum_utils.dart';
import '../../domain/entities/ticket_type.dart';

part 'ticket_type.g.dart';

@JsonSerializable()
class TicketType extends TicketTypeEntity {
  const TicketType({
    required super.ticketTypeId,
    required super.ticketTypeName,
    required super.tourId,
    required super.ticketPrice,
    required super.ticketDescription,
    required super.category,
    required super.quantity,
  });

  TicketType copyWith({
    String? ticketTypeId,
    String? ticketTypeName,
    String? tourId,
    num? ticketPrice,
    String? ticketDescription,
    TicketCategory? category,
    int? quantity,
  }) {
    return TicketType(
      ticketTypeId: ticketTypeId ?? this.ticketTypeId,
      ticketTypeName: ticketTypeName ?? this.ticketTypeName,
      tourId: tourId ?? this.tourId,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketDescription: ticketDescription ?? this.ticketDescription,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "ticketTypeId": ticketTypeId,
      "ticketTypeName": ticketTypeName,
      "tourId": tourId,
      "ticketPrice": ticketPrice,
      "ticketDescription": ticketDescription,
      "category": enumToString(category),
      "quantity": quantity,
    };
  }

  factory TicketType.fromMap(Map<String, dynamic> map) {
    return TicketType(
      ticketTypeId: map["ticketTypeId"],
      ticketTypeName: map["ticketTypeName"],
      tourId: map["tourId"],
      ticketPrice: map["ticketPrice"],
      ticketDescription: map["ticketDescription"],
      category: stringToEnum(map["category"], TicketCategory.values),
      quantity: map["quantity"]?.toInt(),
    );
  }

  factory TicketType.fromJson(Map<String, dynamic> json) =>
      _$TicketTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TicketTypeToJson(this);

  @override
  String toString() {
    return "TicketType(ticketTypeId: $ticketTypeId, ticketTypeName: $ticketTypeName, tourId: $tourId, ticketPrice: $ticketPrice, ticketDescription: $ticketDescription, category: $category, quantity: $quantity)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TicketType &&
        other.ticketTypeId == ticketTypeId &&
        other.ticketTypeName == ticketTypeName &&
        other.tourId == tourId &&
        other.ticketPrice == ticketPrice &&
        other.ticketDescription == ticketDescription &&
        other.category == category &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return ticketTypeId.hashCode ^
        ticketTypeName.hashCode ^
        tourId.hashCode ^
        ticketPrice.hashCode ^
        ticketDescription.hashCode ^
        category.hashCode ^
        quantity.hashCode;
  }
}
