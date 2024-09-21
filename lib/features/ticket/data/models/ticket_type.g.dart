// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketType _$TicketTypeFromJson(Map<String, dynamic> json) => TicketType(
      ticketTypeId: json['ticketTypeId'] as String,
      ticketTypeName: json['ticketTypeName'] as String,
      tourId: json['tourId'] as String,
      ticketPrice: json['ticketPrice'] as num,
      ticketDescription: json['ticketDescription'] as String,
      category: $enumDecode(_$TicketCategoryEnumMap, json['category']),
      quantity: (json['quantity'] as num).toInt(),
      ticketInfo: json['ticketInfo'] as String,
      refundPolicyId: json['refundPolicyId'] as String,
      reschedulePolicyId: json['reschedulePolicyId'] as String,
      redemptionMethodDesc: json['redemptionMethodDesc'] as String,
    );

Map<String, dynamic> _$TicketTypeToJson(TicketType instance) =>
    <String, dynamic>{
      'ticketTypeId': instance.ticketTypeId,
      'ticketTypeName': instance.ticketTypeName,
      'tourId': instance.tourId,
      'ticketPrice': instance.ticketPrice,
      'ticketDescription': instance.ticketDescription,
      'category': _$TicketCategoryEnumMap[instance.category]!,
      'quantity': instance.quantity,
      'ticketInfo': instance.ticketInfo,
      'redemptionMethodDesc': instance.redemptionMethodDesc,
      'refundPolicyId': instance.refundPolicyId,
      'reschedulePolicyId': instance.reschedulePolicyId,
    };

const _$TicketCategoryEnumMap = {
  TicketCategory.adult: 'adult',
  TicketCategory.child: 'child',
  TicketCategory.free: 'free',
};
