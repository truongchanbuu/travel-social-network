part of 'policy_bloc.dart';

abstract class PolicyEvent extends Equatable {
  const PolicyEvent();

  @override
  List<Object?> get props => [];
}

class InitializeNewPolicy extends PolicyEvent {
  final PolicyType policyType;

  const InitializeNewPolicy(this.policyType);

  @override
  List<Object?> get props => [policyType];
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
