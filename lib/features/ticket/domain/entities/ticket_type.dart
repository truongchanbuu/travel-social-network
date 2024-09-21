import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../cores/enums/ticket_category.dart';

@JsonSerializable()
class TicketTypeEntity extends Equatable {
  final String ticketTypeId;
  final String ticketTypeName;
  final String tourId;
  final num ticketPrice;
  final String ticketDescription;
  final DateTime expiredAt;
  final TicketCategory category;
  final int quantity;
  final String ticketInfo;
  final String redemptionMethodDesc;
  final String refundPolicyId;
  final String reschedulePolicyId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const TicketTypeEntity({
    required this.ticketTypeId,
    required this.ticketTypeName,
    required this.tourId,
    required this.ticketPrice,
    required this.ticketDescription,
    required this.expiredAt,
    required this.category,
    required this.quantity,
    required this.ticketInfo,
    required this.redemptionMethodDesc,
    required this.refundPolicyId,
    required this.reschedulePolicyId,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      ticketTypeId,
      ticketTypeName,
      tourId,
      ticketPrice,
      ticketDescription,
      category,
      quantity,
      ticketInfo,
      redemptionMethodDesc,
      refundPolicyId,
      reschedulePolicyId,
      createdAt,
      expiredAt,
    ];
  }
}
