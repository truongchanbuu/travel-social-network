// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Policy _$PolicyFromJson(Map<String, dynamic> json) => Policy(
      policyId: json['policyId'] as String,
      policyName: json['policyName'] as String,
      policyDescription: json['policyDescription'] as String,
      isAllowed: json['isAllowed'] as bool,
      policyType: $enumDecode(_$PolicyTypeEnumMap, json['policyType']),
    );

Map<String, dynamic> _$PolicyToJson(Policy instance) => <String, dynamic>{
      'policyId': instance.policyId,
      'policyName': instance.policyName,
      'policyDescription': instance.policyDescription,
      'policyType': _$PolicyTypeEnumMap[instance.policyType]!,
      'isAllowed': instance.isAllowed,
    };

const _$PolicyTypeEnumMap = {
  PolicyType.refund: 'refund',
  PolicyType.reschedule: 'reschedule',
};
