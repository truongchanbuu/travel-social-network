part of 'policy_bloc.dart';

abstract class PolicyState extends Equatable {
  const PolicyState();

  @override
  List<Object?> get props => [];
}

final class PolicyInitial extends PolicyState {}

final class PolicyActionLoading extends PolicyState {}

final class PolicyLoaded extends PolicyState {
  final Policy policy;
  const PolicyLoaded(this.policy);

  @override
  List<Object?> get props => [policy];
}

final class PolicyActionSuccess extends PolicyState {
  final Policy policy;
  const PolicyActionSuccess(this.policy);

  @override
  List<Object?> get props => [policy];
}

final class PolicyFailure extends PolicyState {
  final String message;
  const PolicyFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class PolicyDeleted extends PolicyState {}
