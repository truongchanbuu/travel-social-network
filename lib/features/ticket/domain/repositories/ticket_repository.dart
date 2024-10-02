import '../../../../cores/resources/data_state.dart';
import '../../data/models/ticket_type.dart';

abstract class TicketRepository {
  Future<DataState<TicketType>> createTicket(TicketType ticket);
  Future<DataState<List<TicketType>>> createTickets(List<TicketType> tickets);
}
