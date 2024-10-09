import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/enums/policy_type.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/policy.dart';
import '../../domain/repositories/policy_repository.dart';

part 'policy_event.dart';
part 'policy_state.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  final PolicyRepository policyRepository;

  PolicyBloc(this.policyRepository) : super(PolicyInitial()) {
    on<InitializeNewPolicy>(_onInitializeNewPolicy);
    on<GetPolicyById>(_onGetPolicyById);
    on<UpdatePolicyName>(_onUpdatePolicyName);
    on<UpdatePolicyDescription>(_onUpdatePolicyDescription);
    on<UpdatePolicyAllowed>(_onUpdatePolicyAllowed);
    on<CreatePolicyEvent>(_onCreatePolicy);
    on<DeletePolicyEvent>(_onDeletePolicy);
  }

  void _onInitializeNewPolicy(
      InitializeNewPolicy event, Emitter<PolicyState> emit) {
    final newPolicy = Policy(
      policyId: 'POLICY-${const Uuid().v4()}',
      policyName: event.policyName,
      policyDescription: event.policyName,
      isAllowed: event.isAllow,
      policyType: event.policyType,
    );
    emit(PolicyLoaded(newPolicy));
  }

  Future<void> _onGetPolicyById(
      GetPolicyById event, Emitter<PolicyState> emit) async {
    try {
      final dataState = await policyRepository.getPolicyById(event.policyId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(PolicyFailure(S.current.dataStateFailure));
      } else if (dataState is DataSuccess) {
        emit(PolicyLoaded(dataState.data!));
      } else {
        emit(PolicyActionLoading());
      }
    } catch (e) {
      emit(PolicyFailure(e.toString()));
    }
  }

  void _onUpdatePolicyName(UpdatePolicyName event, Emitter<PolicyState> emit) {
    if (state is PolicyLoaded) {
      final currentPolicy = (state as PolicyLoaded).policy;
      final updatedPolicy = currentPolicy.copyWith(policyName: event.name);
      emit(PolicyLoaded(updatedPolicy));
    }
  }

  void _onUpdatePolicyDescription(
      UpdatePolicyDescription event, Emitter<PolicyState> emit) {
    if (state is PolicyLoaded) {
      final currentPolicy = (state as PolicyLoaded).policy;
      final updatedPolicy =
          currentPolicy.copyWith(policyDescription: event.description);
      emit(PolicyLoaded(updatedPolicy));
    }
  }

  void _onUpdatePolicyAllowed(
      UpdatePolicyAllowed event, Emitter<PolicyState> emit) {
    if (state is PolicyLoaded) {
      final currentPolicy = (state as PolicyLoaded).policy;
      final updatedPolicy = currentPolicy.copyWith(isAllowed: event.isAllowed);
      emit(PolicyLoaded(updatedPolicy));
    }
  }

  Future<void> _onCreatePolicy(
      CreatePolicyEvent event, Emitter<PolicyState> emit) async {
    try {
      final dataState = await policyRepository.createPolicy(event.policy);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(PolicyFailure(S.current.dataStateFailure));
      } else if (dataState is DataSuccess) {
        emit(PolicyActionSuccess(dataState.data!));
      } else {
        emit(PolicyActionLoading());
      }
    } catch (e) {
      emit(PolicyFailure(e.toString()));
    }
  }

  Future<void> _onDeletePolicy(
      DeletePolicyEvent event, Emitter<PolicyState> emit) async {
    try {
      final dataState = await policyRepository.deletePolicyById(event.policyId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(PolicyFailure(S.current.dataStateFailure));
      } else if (dataState is DataSuccess) {
        emit(PolicyDeleted());
      } else {
        emit(PolicyActionLoading());
      }
    } catch (e) {
      emit(PolicyFailure(e.toString()));
    }
  }
}
