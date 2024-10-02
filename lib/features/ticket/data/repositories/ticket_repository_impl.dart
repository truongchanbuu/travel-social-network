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
}
