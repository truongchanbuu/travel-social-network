part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

final class TicketInitial extends TicketState {}

final class TicketSaving extends TicketState {}

final class ListOfTicketSaveSuccess extends TicketState {
  final List<TicketType> tickets;
  const ListOfTicketSaveSuccess(this.tickets);
}

final class TicketSaveSuccess extends TicketState {
  final TicketType ticket;
  const TicketSaveSuccess(this.ticket);
}

final class TicketSaveFailure extends TicketState {
  final String message;
  const TicketSaveFailure(this.message);
}
