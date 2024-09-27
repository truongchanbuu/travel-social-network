import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/enums/ticket_category.dart';

@JsonSerializable()
class TicketTypeEntity extends Equatable {
  final String ticketTypeId;
  final String ticketTypeName;
  final String tourId;
  final num ticketPrice;
  final String ticketDescription;
  final DateTime startDate;
  final DateTime endDate;
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
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.quantity,
    required this.ticketInfo,
    required this.redemptionMethodDesc,
    required this.refundPolicyId,
    required this.reschedulePolicyId,
    required this.createdAt,
    this.updatedAt,
  });

  TicketTypeEntity.defaultWithId({
    this.tourId = '',
    this.ticketTypeName = '',
    DateTime? startDate,
    DateTime? endDate,
    this.ticketPrice = 0,
    this.ticketDescription = '',
    this.quantity = 0,
    this.refundPolicyId = '',
    this.redemptionMethodDesc = '',
    this.reschedulePolicyId = '',
    this.ticketInfo = '',
    this.category = TicketCategory.adult,
    this.updatedAt,
  })  : ticketTypeId = const Uuid().v4(),
        startDate = startDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now(),
        createdAt = DateTime.now();

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
      startDate,
      endDate
    ];
  }
}
