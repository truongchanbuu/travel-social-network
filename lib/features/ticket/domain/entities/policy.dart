import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../cores/enums/policy_type.dart';

@JsonSerializable()
class PolicyEntity extends Equatable {
  final String policyId;
  final String policyName;
  final String policyDescription;
  final PolicyType policyType;
  final bool isAllowed;

  const PolicyEntity({
    required this.policyId,
    required this.policyName,
    required this.policyDescription,
    required this.isAllowed,
    required this.policyType,
  });

  @override
  List<Object> get props => [
        policyId,
        policyName,
        policyDescription,
        isAllowed,
        policyType,
      ];
}
