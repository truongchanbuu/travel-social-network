import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../cores/resources/data_state.dart';
import '../../data/models/ticket_type.dart';
import '../../domain/repositories/ticket_repository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository _ticketRepository;

  TicketBloc(this._ticketRepository) : super(TicketInitial()) {
    on<CreateTicketEvent>((event, emit) async {
      try {
        final dataState = await _ticketRepository.createTicket(event.ticket);

        if (dataState is DataFailure) {
          emit(TicketSaveFailure(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else if (dataState is DataSuccess) {
          emit(TicketSaveSuccess(dataState.data!));
        } else {
          emit(TicketSaving());
        }
      } catch (e) {
        emit(TicketSaveFailure('Error: $e'));
      }
    });

    on<CreateListOfTicketEvent>((event, emit) async {
      try {
        final dataState = await _ticketRepository.createTickets(event.tickets);

        if (dataState is DataFailure) {
          emit(TicketSaveFailure(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else if (dataState is DataSuccess) {
          emit(ListOfTicketSaveSuccess(dataState.data!));
        } else {
          emit(TicketSaving());
        }
      } catch (e) {
        emit(TicketSaveFailure('Error: $e'));
      }
    });
  }
}
