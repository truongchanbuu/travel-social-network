part of 'policy_bloc.dart';

abstract class PolicyEvent extends Equatable {
  const PolicyEvent();

  @override
  List<Object?> get props => [];
}

class InitializeNewPolicy extends PolicyEvent {
  final String policyName;
  final PolicyType policyType;
  final bool isAllow;

  const InitializeNewPolicy({
    required this.policyName,
    required this.policyType,
    required this.isAllow,
  });

  @override
  List<Object?> get props => [policyName, policyType, isAllow];
}

class GetPolicyById extends PolicyEvent {
  final String policyId;

  const GetPolicyById(this.policyId);

  @override
  List<Object?> get props => [policyId];
}

class UpdatePolicyName extends PolicyEvent {
  final String name;
  const UpdatePolicyName(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdatePolicyDescription extends PolicyEvent {
  final String description;

  const UpdatePolicyDescription(this.description);

  @override
  List<Object?> get props => [description];
}

class UpdatePolicyAllowed extends PolicyEvent {
  final bool isAllowed;

  const UpdatePolicyAllowed(this.isAllowed);

  @override
  List<Object?> get props => [isAllowed];
}

class CreatePolicyEvent extends PolicyEvent {
  final Policy policy;

  const CreatePolicyEvent(this.policy);

  @override
  List<Object?> get props => [policy];
}

class DeletePolicyEvent extends PolicyEvent {
  final String policyId;
  const DeletePolicyEvent(this.policyId);

  @override
  List<Object?> get props => [policyId];
}
