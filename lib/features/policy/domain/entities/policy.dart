import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

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

  PolicyEntity copyWith({
    String? policyName,
    bool? isAllowed,
    String? policyDescription,
  }) {
    return PolicyEntity(
      policyId: policyId,
      policyName: policyName ?? this.policyName,
      policyDescription: policyDescription ?? this.policyDescription,
      isAllowed: isAllowed ?? this.isAllowed,
      policyType: policyType,
    );
  }

  PolicyEntity.nonRefundable({
    this.policyName = 'Cannot Refund',
    this.isAllowed = false,
    this.policyType = PolicyType.refund,
    required this.policyDescription,
  }) : policyId = 'RF-${const Uuid().v4()}';

  PolicyEntity.cannotReschedule({
    this.policyName = 'Cannot Reschedule',
    this.policyType = PolicyType.reschedule,
    this.isAllowed = false,
    required this.policyDescription,
  }) : policyId = 'RS-${const Uuid().v4()}';

  @override
  List<Object> get props => [
        policyId,
        policyName,
        policyDescription,
        isAllowed,
        policyType,
      ];
}
