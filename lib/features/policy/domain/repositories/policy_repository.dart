import '../../../../cores/resources/data_state.dart';
import '../../data/models/policy.dart';

abstract interface class PolicyRepository {
  Future<DataState<Policy>> createPolicy(Policy policy);
  Future<DataState<List<Policy>>> createPolicies(List<Policy> policies);
  Future<DataState<Policy>> getPolicyById(String id);
  Future<DataState<Policy>> updatePolicyById(String id, Policy newPolicy);
  Future<DataState<void>> deletePolicyById(String id);
}
