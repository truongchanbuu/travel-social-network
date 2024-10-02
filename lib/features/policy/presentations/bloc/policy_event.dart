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

final class CreateListOfPolicyEvent extends PolicyEvent {
  final List<Policy> policies;
  const CreateListOfPolicyEvent(this.policies);
}

final class GetPolicyById extends PolicyEvent {
  final String id;
  const GetPolicyById(this.id);
}
