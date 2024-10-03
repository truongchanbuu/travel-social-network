import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/policy.dart';
import '../../domain/repositories/policy_repository.dart';
part 'policy_event.dart';
part 'policy_state.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  final PolicyRepository policyRepository;

  PolicyBloc({required this.policyRepository}) : super(PolicyInitial()) {
    on<InitializeNewPolicy>(_onInitializeNewPolicy);
    on<GetPolicyById>(_onGetPolicyById);
    on<UpdatePolicyName>(_onUpdatePolicyName);
    on<UpdatePolicyDescription>(_onUpdatePolicyDescription);
    on<UpdatePolicyAllowed>(_onUpdatePolicyAllowed);
    on<CreatePolicyEvent>(_onCreatePolicy);
  }

  void _onInitializeNewPolicy(
      InitializeNewPolicy event, Emitter<PolicyState> emit) {
    final newPolicy = Policy(
      policyId: 'POLICY-${const Uuid().v4()}',
      policyName: '',
      policyDescription: '',
      isAllowed: true,
      policyType: event.policyType,
    );
    emit(PolicyLoaded(newPolicy));
  }

  Future<void> _onGetPolicyById(
      GetPolicyById event, Emitter<PolicyState> emit) async {
    emit(PolicyLoading());
    try {
      final policy = await policyRepository.getPolicyById(event.policyId);
      emit(PolicyLoaded(policy));
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
    emit(PolicyLoading());
    try {
      final createdPolicy = await policyRepository.createPolicy(event.policy);
      emit(PolicyCreateSuccess(createdPolicy));
    } catch (e) {
      emit(PolicyFailure(e.toString()));
    }
  }
}
