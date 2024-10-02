import 'package:json_annotation/json_annotation.dart';

import '../../../../cores/enums/policy_type.dart';
import '../../../../cores/utils/enum_utils.dart';
import '../../domain/entities/policy.dart';

part 'policy.g.dart';

@JsonSerializable()
class Policy extends PolicyEntity {
  const Policy({
    required super.policyId,
    required super.policyName,
    required super.policyDescription,
    required super.isAllowed,
    required super.policyType,
  });

  Policy copyWith({
    String? policyId,
    String? policyName,
    String? policyDescription,
    bool? isAllowed,
    PolicyType? policyType,
  }) {
    return Policy(
      policyId: policyId ?? this.policyId,
      policyName: policyName ?? this.policyName,
      policyDescription: policyDescription ?? this.policyDescription,
      isAllowed: isAllowed ?? this.isAllowed,
      policyType: policyType ?? this.policyType,
    );
  }

  PolicyEntity toEntity() {
    return PolicyEntity(
      policyId: policyId,
      policyName: policyName,
      policyDescription: policyDescription,
      isAllowed: isAllowed,
      policyType: policyType,
    );
  }

  factory Policy.fromEntity(PolicyEntity entity) {
    return Policy(
      policyId: entity.policyId,
      policyName: entity.policyName,
      policyDescription: entity.policyDescription,
      isAllowed: entity.isAllowed,
      policyType: entity.policyType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'policyId': policyId,
      'policyName': policyName,
      'policyDescription': policyDescription,
      'isAllowed': isAllowed,
      "policyType": policyType.name,
    };
  }

  factory Policy.fromMap(Map<String, dynamic> map) {
    return Policy(
      policyId: map['policyId'] ?? '',
      policyName: map['policyName'] ?? '',
      policyDescription: map['policyDescription'] ?? '',
      isAllowed: map['isAllowed'] ?? false,
      policyType: stringToEnum(map['policyType'], PolicyType.values),
    );
  }

  Map<String, dynamic> toJson() => _$PolicyToJson(this);

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);
}
