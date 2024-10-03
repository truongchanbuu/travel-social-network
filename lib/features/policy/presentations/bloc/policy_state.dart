part of 'policy_bloc.dart';

sealed class PolicyState extends Equatable {
  const PolicyState();

  @override
  List<Object> get props => [];
}

final class PolicyInitial extends PolicyState {}

final class PolicyFailure extends PolicyState {
  final String message;
  const PolicyFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class PolicyCreating extends PolicyState {}

final class PolicyCreateSuccess extends PolicyState {
  final Policy policy;
  const PolicyCreateSuccess(this.policy);

  @override
  List<Object> get props => [policy];
}

final class ListOfPolicyCreateSuccess extends PolicyState {
  final List<Policy> policies;
  const ListOfPolicyCreateSuccess(this.policies);

  @override
  List<Object> get props => [policies];
}

final class PolicyGetting extends PolicyState {}

final class PolicyGetSuccess extends PolicyState {
  final Policy policy;
  const PolicyGetSuccess(this.policy);

  @override
  List<Object> get props => [policy];
}

final class PolicyUpdating extends PolicyState {}

final class PolicyUpdateSuccess extends PolicyState {
  final Policy policy;
  const PolicyUpdateSuccess(this.policy);

  @override
  List<Object> get props => [policy];
}
