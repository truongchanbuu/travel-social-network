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

  @override
  List<Object> get props => [message];
}

final class TicketCreating extends TicketState {}

final class ListOfTicketSaveSuccess extends TicketState {
  final List<TicketType> tickets;
  const ListOfTicketSaveSuccess(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class TicketSaveSuccess extends TicketState {
  final TicketType ticket;
  const TicketSaveSuccess(this.ticket);

  @override
  List<Object> get props => [ticket];
}

final class TicketUpdating extends TicketState {}

final class TicketUpdateSuccess extends TicketState {
  final TicketType ticket;
  const TicketUpdateSuccess(this.ticket);

  @override
  List<Object> get props => [ticket];
}

final class ListOfTicketsGetting extends TicketState {}

final class ListOfTicketGetSuccess extends TicketState {
  final List<TicketType> tickets;
  const ListOfTicketGetSuccess(this.tickets);

  @override
  List<Object> get props => [tickets];
}
