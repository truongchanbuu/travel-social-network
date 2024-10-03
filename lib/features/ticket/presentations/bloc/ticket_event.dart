part of 'ticket_bloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

final class CreateTicketEvent extends TicketEvent {
  final TicketType ticket;
  const CreateTicketEvent(this.ticket);

  @override
  List<Object> get props => [ticket];
}

final class CreateListOfTicketsEvent extends TicketEvent {
  final List<TicketType> tickets;
  const CreateListOfTicketsEvent(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class UpdateTicketEvent extends TicketEvent {
  final String id;
  final TicketType newTicket;
  const UpdateTicketEvent({required this.id, required this.newTicket});

  @override
  List<Object> get props => [id, newTicket];
}

final class GetAllTicketsByTourId extends TicketEvent {
  final String tourId;
  const GetAllTicketsByTourId(this.tourId);

  @override
  List<Object> get props => [tourId];
}
