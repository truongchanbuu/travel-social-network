import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          emit(TicketFailure(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else if (dataState is DataSuccess) {
          emit(TicketSaveSuccess(dataState.data!));
        } else {
          emit(TicketCreating());
        }
      } catch (e) {
        emit(TicketFailure('Error: $e'));
      }
    });

    on<CreateListOfTicketsEvent>((event, emit) async {
      try {
        final dataState = await _ticketRepository.createTickets(event.tickets);

        if (dataState is DataFailure) {
          emit(TicketFailure(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else if (dataState is DataSuccess) {
          emit(ListOfTicketSaveSuccess(dataState.data!));
        } else {
          emit(TicketCreating());
        }
      } catch (e) {
        emit(TicketFailure('Error: $e'));
      }
    });

    on<UpdateTicketEvent>(
      (event, emit) async {
        try {
          print('UPDATE TIC');
          final dataState =
              await _ticketRepository.updateTicket(event.id, event.newTicket);

          print(dataState);
          if (dataState is DataFailure) {
            emit(TicketFailure(dataState.error?.message ??
                'ERROR OCCURRED: ${dataState.error}'));
          } else if (dataState is DataSuccess) {
            emit(TicketUpdateSuccess(dataState.data!));
          } else {
            emit(TicketUpdating());
          }
        } catch (e) {
          emit(TicketFailure('Error: $e'));
        }
      },
    );

    on<GetAllTicketsByTourId>(
      (event, emit) async {
        try {
          final dataState =
              await _ticketRepository.getAllTicketsByTourId(event.tourId);

          if (dataState is DataFailure) {
            emit(TicketFailure(dataState.error?.message ??
                'ERROR OCCURRED: ${dataState.error}'));
          } else if (dataState is DataSuccess) {
            emit(ListOfTicketGetSuccess(dataState.data!));
          } else {
            emit(ListOfTicketsGetting());
          }
        } catch (e) {
          emit(TicketFailure('Error: $e'));
        }
      },
    );
  }
}
