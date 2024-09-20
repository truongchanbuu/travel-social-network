// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      ticketId: json['ticketId'] as String,
      tourId: json['tourId'] as String,
      ticketTypeId: json['ticketTypeId'] as String,
      customerId: json['customerId'] as String,
      purchasedDate: DateTime.parse(json['purchasedDate'] as String),
      ticketPrice: json['ticketPrice'] as num,
      discount: (json['discount'] as num).toDouble(),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'ticketId': instance.ticketId,
      'tourId': instance.tourId,
      'ticketTypeId': instance.ticketTypeId,
      'customerId': instance.customerId,
      'purchasedDate': instance.purchasedDate.toIso8601String(),
      'ticketPrice': instance.ticketPrice,
      'discount': instance.discount,
    };
