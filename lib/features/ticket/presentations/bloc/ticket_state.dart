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
  final TicketType ticket;
  const TicketLoaded(this.ticket);

  @override
  List<Object> get props => [ticket];
}

final class ListOfTicketsLoaded extends TicketState {
  final List<TicketType> tickets;
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
  final List<TicketType> tickets;
  const ListOfTicketsSuccess(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class TicketDuplicated extends TicketState {
  final TicketTypeEntity ticket;
  const TicketDuplicated(this.ticket);

  @override
  List<Object> get props => [ticket];
}

final class TicketUnDuplicated extends TicketState {}
