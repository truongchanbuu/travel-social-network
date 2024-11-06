part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

final class TicketInitial extends TicketState {}

final class TicketActionLoading extends TicketState {}

final class TicketFailure extends TicketState {
  final String message;
  const TicketFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class TicketLoaded extends TicketState {
  final TicketTypeEntity ticket;
  const TicketLoaded(this.ticket);

  @override
  List<Object> get props => [ticket];
}

final class ListOfTicketsLoaded extends TicketState {
  final List<TicketTypeEntity> tickets;
  const ListOfTicketsLoaded(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class TicketActionSuccess extends TicketState {
  final TicketTypeEntity ticket;
  const TicketActionSuccess(this.ticket);

  @override
  List<Object> get props => [ticket];
}

final class ListOfTicketsSuccess extends TicketState {
  final List<TicketTypeEntity> tickets;
  const ListOfTicketsSuccess(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class TicketsGenerated extends TicketState {
  final List<TicketTypeEntity> validTickets;
  final List<TicketTypeEntity> invalidTickets;

  const TicketsGenerated({
    required this.validTickets,
    required this.invalidTickets,
  });

  @override
  List<Object> get props => [validTickets, invalidTickets];
}

final class TicketDeleted extends TicketState {
  final TicketTypeEntity ticket;
  const TicketDeleted(this.ticket);

  @override
  List<Object> get props => [ticket];
}
