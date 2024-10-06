import '../../../../cores/resources/data_state.dart';
import '../../data/models/ticket_type.dart';

abstract class TicketRepository {
  Future<DataState<TicketType>> createTicket(TicketType ticket);
  Future<DataState<List<TicketType>>> createTickets(List<TicketType> tickets);
  Future<DataState<TicketType>> updateTicket(String id, TicketType newTicket);
  Future<DataState<TicketType>> deleteTicketById(String id);
  Future<DataState<List<TicketType>>> getAllTicketsByTourId(String tourId);
  Future<DataState<TicketType>> getTourTicketWithNameAndCategoryInDate({
    required String tourId,
    required String name,
    required String category,
    required DateTime startDate,
    required DateTime endDate,
  });
}
