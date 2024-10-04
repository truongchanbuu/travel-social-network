import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../domain/repositories/policy_repository.dart';
import '../models/policy.dart';

class PolicyRepositoryImpl implements PolicyRepository {
  final CollectionReference policyCollection = db.collection('policies');

  @override
  Future<DataState<Policy>> createPolicy(Policy policy) async {
    try {
      await policyCollection.doc(policy.policyId).set(policy.toJson());
      return DataSuccess(data: policy);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<Policy>>> createPolicies(List<Policy> policies) async {
    try {
      WriteBatch batch = firestore.batch();

      for (var policy in policies) {
        final policyRef = policyCollection.doc(policy.policyId);
        batch.set(policyRef, policy.toJson());
      }

      await batch.commit();
      return DataSuccess(data: policies);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<Policy>> getPolicyById(String id) async {
    try {
      final docRef = policyCollection.doc(id);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure('Not found');
      }

      Map<String, dynamic>? policyData =
          docSnap.data() as Map<String, dynamic>?;

      if (policyData != null) {
        Policy policy = Policy.fromJson(policyData);
        return DataSuccess<Policy>(data: policy);
      }

      return defaultDataFailure('Document is null');
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<void>> deletePolicyById(String id) async {
    try {
      final docRef = policyCollection.doc(id);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure('Not found');
      }

      await docRef.delete();
      return defaultDataFailure('Document is null');
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<Policy>> updatePolicyById(
      String id, Policy newPolicy) async {
    try {
      final docRef = policyCollection.doc(id);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure('Not found');
      }

      await docRef.update(newPolicy.toJson());
      return defaultDataFailure('Document is null');
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }
}
