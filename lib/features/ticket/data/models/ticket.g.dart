// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      ticketId: json['ticketId'] as String,
      category: $enumDecode(_$TicketCategoryEnumMap, json['category']),
      tourId: json['tourId'] as String,
      ticketTypeId: json['ticketTypeId'] as String,
      customerId: json['customerId'] as String,
      purchasedDate: DateTime.parse(json['purchasedDate'] as String),
      quantity: (json['quantity'] as num).toInt(),
      ticketPrice: json['ticketPrice'] as num,
      discount: (json['discount'] as num).toDouble(),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'ticketId': instance.ticketId,
      'category': _$TicketCategoryEnumMap[instance.category]!,
      'tourId': instance.tourId,
      'ticketTypeId': instance.ticketTypeId,
      'customerId': instance.customerId,
      'purchasedDate': instance.purchasedDate.toIso8601String(),
      'ticketPrice': instance.ticketPrice,
      'quantity': instance.quantity,
      'discount': instance.discount,
    };

const _$TicketCategoryEnumMap = {
  TicketCategory.adult: 'adult',
  TicketCategory.child: 'child',
  TicketCategory.student: 'student',
  TicketCategory.standard: 'standard',
  TicketCategory.vip: 'vip',
  TicketCategory.early_bird: 'early_bird',
  TicketCategory.free: 'free',
};
