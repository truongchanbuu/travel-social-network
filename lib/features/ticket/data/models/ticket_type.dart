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
    required super.ticketInfo,
    required super.refundPolicyId,
    required super.reschedulePolicyId,
    required super.redemptionMethodDesc,
  });

  TicketType copyWith({
    String? ticketTypeId,
    String? ticketTypeName,
    String? tourId,
    num? ticketPrice,
    String? ticketDescription,
    TicketCategory? category,
    int? quantity,
    String? ticketInfo,
    String? refundPolicyId,
    String? reschedulePolicyId,
    String? redemptionMethodDesc,
  }) {
    return TicketType(
      ticketTypeId: ticketTypeId ?? this.ticketTypeId,
      ticketTypeName: ticketTypeName ?? this.ticketTypeName,
      tourId: tourId ?? this.tourId,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketDescription: ticketDescription ?? this.ticketDescription,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      ticketInfo: ticketInfo ?? this.ticketInfo,
      refundPolicyId: refundPolicyId ?? this.refundPolicyId,
      reschedulePolicyId: reschedulePolicyId ?? this.reschedulePolicyId,
      redemptionMethodDesc: redemptionMethodDesc ?? this.redemptionMethodDesc,
    );
  }

  TicketTypeEntity toEntity() {
    return TicketTypeEntity(
      ticketTypeId: ticketTypeId,
      ticketTypeName: ticketTypeName,
      tourId: tourId,
      ticketPrice: ticketPrice,
      ticketDescription: ticketDescription,
      category: category,
      quantity: quantity,
      ticketInfo: ticketInfo,
      refundPolicyId: refundPolicyId,
      reschedulePolicyId: reschedulePolicyId,
      redemptionMethodDesc: redemptionMethodDesc,
    );
  }

  factory TicketType.fromEntity(TicketTypeEntity entity) {
    return TicketType(
      ticketTypeId: entity.ticketTypeId,
      ticketTypeName: entity.ticketTypeName,
      tourId: entity.tourId,
      ticketPrice: entity.ticketPrice,
      ticketDescription: entity.ticketDescription,
      category: entity.category,
      quantity: entity.quantity,
      ticketInfo: entity.ticketInfo,
      refundPolicyId: entity.refundPolicyId,
      reschedulePolicyId: entity.reschedulePolicyId,
      redemptionMethodDesc: entity.redemptionMethodDesc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "ticketTypeId": ticketTypeId,
      "ticketTypeName": ticketTypeName,
      "tourId": tourId,
      "ticketPrice": ticketPrice,
      "ticketDescription": ticketDescription,
      "category": category.name,
      "quantity": quantity,
      "ticketInfo": ticketInfo,
      "refundPolicyId": refundPolicyId,
      "reschedulePolicyId": reschedulePolicyId,
      "redemptionMethodDesc": redemptionMethodDesc,
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
      ticketInfo: map["ticketInfo"],
      refundPolicyId: map["refundPolicyId"],
      reschedulePolicyId: map["reschedulePolicyId"],
      redemptionMethodDesc: map["redemptionMethodDesc"],
    );
  }

  factory TicketType.fromJson(Map<String, dynamic> json) =>
      _$TicketTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TicketTypeToJson(this);
}