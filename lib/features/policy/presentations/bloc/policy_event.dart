part of 'policy_bloc.dart';

sealed class PolicyEvent extends Equatable {
  const PolicyEvent();

  @override
  List<Object> get props => [];
}

final class CreatePolicyEvent extends PolicyEvent {
  final Policy policy;
  const CreatePolicyEvent(this.policy);
}

final class CreateListOfPoliciesEvent extends PolicyEvent {
  final List<Policy> policies;
  const CreateListOfPoliciesEvent(this.policies);
}

final class GetPolicyById extends PolicyEvent {
  final String id;
  const GetPolicyById(this.id);
}

final class UpdatePolicyEvent extends PolicyEvent {
  final String id;
  final Policy policy;

  const UpdatePolicyEvent({required this.id, required this.policy});
}
