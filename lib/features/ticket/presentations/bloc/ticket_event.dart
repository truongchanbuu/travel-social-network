part of 'ticket_bloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

final class InitialNewTicketEvent extends TicketEvent {
  final String tourId;
  const InitialNewTicketEvent(this.tourId);

  @override
  List<Object> get props => [tourId];
}

final class CreateTicketEvent extends TicketEvent {
  final TicketType ticket;
  const CreateTicketEvent(this.ticket);

  @override
  List<Object> get props => [ticket];
}

final class UpdateTicketFieldEvent extends TicketEvent {
  final String field;
  final dynamic value;

  const UpdateTicketFieldEvent(this.field, this.value);

  @override
  List<Object> get props => [field, value];
}

final class CreateListOfTicketsEvent extends TicketEvent {
  final List<TicketTypeEntity> tickets;
  const CreateListOfTicketsEvent(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class UpdateTicketEvent extends TicketEvent {
  final TicketTypeEntity oldTicket;
  final TicketTypeEntity newTicket;
  const UpdateTicketEvent({required this.oldTicket, required this.newTicket});

  @override
  List<Object> get props => [oldTicket, newTicket];
}

final class GetAllTicketsByTourId extends TicketEvent {
  final String tourId;
  const GetAllTicketsByTourId(this.tourId);

  @override
  List<Object> get props => [tourId];
}

final class GenerateListOfTicketsEvent extends TicketEvent {
  final TicketTypeEntity ticket;
  final List<String> selectedRangeDates;

  const GenerateListOfTicketsEvent(this.ticket, this.selectedRangeDates);

  @override
  List<Object> get props => [ticket, selectedRangeDates];
}

final class DeleteTicketEvent extends TicketEvent {
  final String ticketId;
  const DeleteTicketEvent(this.ticketId);

  @override
  List<Object> get props => [ticketId];
}
