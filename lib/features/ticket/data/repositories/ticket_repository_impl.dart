import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/resources/data_state.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../models/ticket_type.dart';

class TicketRepositoryImpl implements TicketRepository {
  final CollectionReference ticketCollection = db.collection('tickets');

  @override
  Future<DataState<TicketType>> createTicket(TicketType ticket) async {
    try {
      await ticketCollection.doc(ticket.ticketTypeId).set(ticket.toJson());
      return DataSuccess(data: ticket);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<TicketType>>> createTickets(
      List<TicketType> tickets) async {
    try {
      final WriteBatch batch = firestore.batch();

      for (var ticket in tickets) {
        final ticketRef = ticketCollection.doc(ticket.ticketTypeId);
        batch.set(ticketRef, ticket.toJson());
      }

      await batch.commit();
      return DataSuccess(data: tickets);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<TicketType>> deleteTicketById(String id) async {
    try {
      final docRef = ticketCollection.doc(id);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure('Not found');
      }

      await docRef.delete();
      return DataSuccess(
        data: TicketType.fromJson(docSnap.data()! as Map<String, dynamic>),
      );
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<TicketType>> updateTicket(
      String id, TicketType newTicket) async {
    try {
      final docRef = ticketCollection.doc(id);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure('Not found');
      }

      newTicket.copyWith(updatedAt: DateTime.now());
      await docRef.update(newTicket.toJson());

      return DataSuccess(data: newTicket);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<TicketType>>> getAllTicketsByTourId(
      String tourId) async {
    try {
      List<TicketType> tickets = [];
      final docQuery = ticketCollection
          .where('tourId', isEqualTo: tourId)
          .orderBy('createdAt', descending: true);

      final docSnaps = await docQuery.get();
      if (docSnaps.docs.isNotEmpty) {
        tickets = docSnaps.docs
            .map((doc) =>
                TicketType.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      }

      return DataSuccess(data: tickets);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<TicketType>> getTourTicketWithNameAndCategoryInDate({
    required String tourId,
    required String name,
    required String category,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final docQuery = ticketCollection
          .where('tourId', isEqualTo: tourId)
          .where('ticketTypeName', isEqualTo: name)
          .where('category', isEqualTo: category)
          .where('startDate', isEqualTo: startDate.toIso8601String())
          .where('endDate', isEqualTo: endDate.toIso8601String())
          .limit(1);

      final docSnaps = await docQuery.get();

      if (docSnaps.docs.isEmpty) {
        return defaultDataFailure('Not found');
      }

      return DataSuccess(
          data: TicketType.fromJson(
              docSnaps.docs.first.data() as Map<String, dynamic>));
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }
}
