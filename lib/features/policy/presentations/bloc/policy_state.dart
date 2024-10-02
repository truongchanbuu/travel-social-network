part of 'policy_bloc.dart';

sealed class PolicyState extends Equatable {
  const PolicyState();

  @override
  List<Object> get props => [];
}

final class PolicyInitial extends PolicyState {}

final class PolicyCreating extends PolicyState {}

final class PolicyCreateSuccess extends PolicyState {
  final Policy policy;
  const PolicyCreateSuccess(this.policy);
}

final class ListOfPolicyCreateSuccess extends PolicyState {
  final List<Policy> policies;
  const ListOfPolicyCreateSuccess(this.policies);
}

final class PolicyCreateFailure extends PolicyState {
  final String message;
  const PolicyCreateFailure(this.message);
}

final class PolicyGetting extends PolicyState {}

final class PolicyGetSuccess extends PolicyState {
  final Policy policy;
  const PolicyGetSuccess(this.policy);
}

final class PolicyGetFailure extends PolicyState {
  final String message;
  const PolicyGetFailure(this.message);
}
