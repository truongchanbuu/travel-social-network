part of 'ticket_bloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

final class CreateTicketEvent extends TicketEvent {
  final TicketType ticket;
  const CreateTicketEvent(this.ticket);
}

final class CreateListOfTicketEvent extends TicketEvent {
  final List<TicketType> tickets;
  const CreateListOfTicketEvent(this.tickets);
}
