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
    };

const _$TicketCategoryEnumMap = {
  TicketCategory.adult: 'adult',
  TicketCategory.child: 'child',
  TicketCategory.free: 'free',
};
