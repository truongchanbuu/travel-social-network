part of 'policy_bloc.dart';

sealed class PolicyEvent extends Equatable {
  const PolicyEvent();

  @override
  List<Object> get props => [];
}

final class CreatePolicyEvent extends PolicyEvent {
  final Policy policy;
  const CreatePolicyEvent(this.policy);

  @override
  List<Object> get props => [policy];
}

final class CreateListOfPoliciesEvent extends PolicyEvent {
  final List<Policy> policies;
  const CreateListOfPoliciesEvent(this.policies);

  @override
  List<Object> get props => [policies];
}

final class GetPolicyById extends PolicyEvent {
  final String id;
  const GetPolicyById(this.id);

  @override
  List<Object> get props => [id];
}

final class UpdatePolicyEvent extends PolicyEvent {
  final String id;
  final Policy policy;

  const UpdatePolicyEvent({required this.id, required this.policy});

  @override
  List<Object> get props => [id, policy];
}
