import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_social_network/cores/resources/data_state.dart';

import '../../data/models/policy.dart';
import '../../domain/repositories/policy_repository.dart';

part 'policy_event.dart';
part 'policy_state.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  final PolicyRepository _policyRepository;

  PolicyBloc(this._policyRepository) : super(PolicyInitial()) {
    on<CreatePolicyEvent>((event, emit) async {
      try {
        final dataState = await _policyRepository.createPolicy(event.policy);

        if (dataState is DataFailure) {
          emit(PolicyFailure(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else if (dataState is DataSuccess) {
          emit(PolicyCreateSuccess(dataState.data!));
        } else {
          emit(PolicyCreating());
        }
      } catch (e) {
        emit(PolicyFailure('Error: $e'));
      }
    });

    on<CreateListOfPoliciesEvent>((event, emit) async {
      try {
        final dataState =
            await _policyRepository.createPolicies(event.policies);

        if (dataState is DataFailure) {
          emit(PolicyFailure(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else if (dataState is DataSuccess) {
          emit(ListOfPolicyCreateSuccess(dataState.data!));
        } else {
          emit(PolicyCreating());
        }
      } catch (e) {
        emit(PolicyFailure('Error: $e'));
      }
    });

    on<GetPolicyById>((event, emit) async {
      try {
        final dataState = await _policyRepository.getPolicyById(event.id);

        if (dataState is DataFailure) {
          emit(PolicyFailure(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else if (dataState is DataSuccess) {
          emit(PolicyGetSuccess(dataState.data!));
        } else {
          emit(PolicyGetting());
        }
      } catch (e) {
        emit(PolicyFailure('Error: $e'));
      }
    });

    on<UpdatePolicyEvent>(
      (event, emit) async {
        try {
          print("UPDATE ${event.id}");
          final dataState =
              await _policyRepository.updatePolicyById(event.id, event.policy);

          print(dataState.error);
          if (dataState is DataFailure) {
            emit(PolicyFailure(dataState.error?.message ??
                'ERROR OCCURRED: ${dataState.error}'));
          } else if (dataState is DataSuccess) {
            emit(PolicyUpdateSuccess(dataState.data!));
          } else {
            emit(PolicyUpdating());
          }
        } catch (e) {
          emit(PolicyFailure('Error: $e'));
        }
      },
    );
  }
}
