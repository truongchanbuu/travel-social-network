import '../../../../cores/resources/data_state.dart';
import '../../data/models/policy.dart';

abstract class PolicyRepository {
  Future<DataState<Policy>> createPolicy(Policy policy);
  Future<DataState<List<Policy>>> createPolicies(List<Policy> policies);
  Future<DataState<Policy>> getPolicyById(String id);
}
