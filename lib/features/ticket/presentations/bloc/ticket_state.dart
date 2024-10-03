part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

final class TicketInitial extends TicketState {}

final class TicketFailure extends TicketState {
  final String message;
  const TicketFailure(this.message);
}

final class TicketCreating extends TicketState {}

final class ListOfTicketSaveSuccess extends TicketState {
  final List<TicketType> tickets;
  const ListOfTicketSaveSuccess(this.tickets);
}

final class TicketSaveSuccess extends TicketState {
  final TicketType ticket;
  const TicketSaveSuccess(this.ticket);
}

final class TicketUpdating extends TicketState {}

final class TicketUpdateSuccess extends TicketState {
  final TicketType ticket;
  const TicketUpdateSuccess(this.ticket);
}

final class ListOfTicketsGetting extends TicketState {}

final class ListOfTicketGetSuccess extends TicketState {
  final List<TicketType> tickets;
  const ListOfTicketGetSuccess(this.tickets);
}