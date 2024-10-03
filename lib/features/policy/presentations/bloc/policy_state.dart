part of 'policy_bloc.dart';

abstract class PolicyState extends Equatable {
  const PolicyState();

  @override
  List<Object?> get props => [];
}

class PolicyInitial extends PolicyState {}

class PolicyLoading extends PolicyState {}

class PolicyLoaded extends PolicyState {
  final Policy policy;
  const PolicyLoaded(this.policy);

  @override
  List<Object?> get props => [policy];
}

class PolicyCreateSuccess extends PolicyState {
  final Policy policy;
  const PolicyCreateSuccess(this.policy);

  @override
  List<Object?> get props => [policy];
}

class PolicyFailure extends PolicyState {
  final String message;
  const PolicyFailure(this.message);

  @override
  List<Object?> get props => [message];
}
