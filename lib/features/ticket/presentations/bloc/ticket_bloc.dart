import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_social_network/features/ticket/domain/entities/ticket_type.dart';

import '../../../../cores/enums/ticket_category.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../data/models/ticket_type.dart';
import '../../domain/repositories/ticket_repository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository _ticketRepository;

  TicketBloc(this._ticketRepository) : super(TicketInitial()) {
    on<InitialNewTicketEvent>(_onInitTicket);
    on<CreateTicketEvent>(_onCreateTicket);
    on<CreateListOfTicketsEvent>(_onCreateListOfTickets);
    on<UpdateTicketEvent>(_onUpdateTicket);
    on<GetAllTicketsByTourId>(_onGetAllTicketsByTourId);
    on<UpdateTicketFieldEvent>(_onUpdateTicketField);
    on<GenerateListOfTicketsEvent>(_onGenerateListOfTickets);
    on<GetTicketByNameAndCategoryEvent>(_onGetTicketByNameAndCategory);
    on<CheckDuplicateTicket>(_onDuplicatedTicketCheck);
  }

  void _onInitTicket(event, emit) {
    final newTicket = TicketTypeEntity.defaultWithId(tourId: event.tourId);
    emit(TicketLoaded(TicketType.fromEntity(newTicket)));
  }

  Future<void> _onCreateTicket(event, emit) async {
    try {
      final dataState = await _ticketRepository.createTicket(event.ticket);

      if (dataState is DataFailure) {
        emit(TicketFailure(
            dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}'));
      } else if (dataState is DataSuccess) {
        emit(TicketLoaded(dataState.data!));
      } else {
        emit(TicketActionLoading());
      }
    } catch (e) {
      emit(TicketFailure('Error: $e'));
    }
  }

  Future<void> _onCreateListOfTickets(event, emit) async {
    try {
      final dataState = await _ticketRepository.createTickets(event.tickets);

      if (dataState is DataFailure) {
        emit(TicketFailure(
            dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}'));
      } else if (dataState is DataSuccess) {
        emit(ListOfTicketsLoaded(dataState.data!));
      } else {
        emit(TicketActionLoading());
      }
    } catch (e) {
      emit(TicketFailure('Error: $e'));
    }
  }

  Future<void> _onUpdateTicket(event, emit) async {
    try {
      print('UPDATE TIC');
      final dataState =
          await _ticketRepository.updateTicket(event.id, event.newTicket);

      print(dataState);
      if (dataState is DataFailure) {
        emit(TicketFailure(
            dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}'));
      } else if (dataState is DataSuccess) {
        emit(TicketLoaded(dataState.data!));
      } else {
        emit(TicketActionLoading());
      }
    } catch (e) {
      emit(TicketFailure('Error: $e'));
    }
  }

  Future<void> _onGetAllTicketsByTourId(event, emit) async {
    try {
      final dataState =
          await _ticketRepository.getAllTicketsByTourId(event.tourId);

      if (dataState is DataFailure) {
        emit(TicketFailure(
            dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}'));
      } else if (dataState is DataSuccess) {
        emit(ListOfTicketsLoaded(dataState.data!));
      } else {
        emit(TicketActionLoading());
      }
    } catch (e) {
      emit(TicketFailure('Error: $e'));
    }
  }

  void _onUpdateTicketField(event, emit) {
    if (state is TicketLoaded) {
      final TicketType currentTicket = (state as TicketLoaded).ticket;
      final TicketType updatedTicket =
          _updateTicketField(currentTicket, event.field, event.value);
      emit(TicketLoaded(updatedTicket));
    }
  }

  TicketType _updateTicketField(
      TicketType ticket, String field, dynamic value) {
    switch (field) {
      case 'ticketTypeName':
        return ticket.copyWith(ticketTypeName: value as String);
      case 'ticketPrice':
        return ticket.copyWith(ticketPrice: value as num);
      case 'quantity':
        return ticket.copyWith(quantity: value as int);
      case 'category':
        return ticket.copyWith(category: value as TicketCategory);
      case 'ticketDescription':
        return ticket.copyWith(ticketDescription: value as String);
      case 'ticketInfo':
        return ticket.copyWith(ticketInfo: value as String);
      case 'redemptionMethodDesc':
        return ticket.copyWith(redemptionMethodDesc: value as String);
      case 'refundPolicyId':
        return ticket.copyWith(refundPolicyId: value as String);
      case 'reschedulePolicyId':
        return ticket.copyWith(reschedulePolicyId: value as String);
      default:
        return ticket;
    }
  }

  Future<void> _onGetTicketByNameAndCategory(event, emit) async {
    try {
      final dataState =
          await _ticketRepository.getTourTicketWithNameAndCategory(
              tourId: event.tourId, name: event.name, category: event.category);

      if (dataState is DataFailure) {
        emit(TicketFailure(
            dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}'));
      } else if (dataState is DataSuccess) {
        emit(TicketActionSuccess(dataState.data!.toEntity()));
      } else {
        emit(TicketActionLoading());
      }
    } catch (e) {
      emit(TicketFailure('Error: $e'));
    }
  }

  void _onGenerateListOfTickets(
      GenerateListOfTicketsEvent event, Emitter<TicketState> emit) async {
    List<TicketType> tickets = [];

    for (var rangeDate in event.selectedRangeDates) {
      final TicketTypeEntity createdTicket =
          _createTicketForDate(event.ticket, rangeDate);
      final transformedTicket = TicketType.fromEntity(createdTicket);
      tickets.add(transformedTicket);

      add(CheckDuplicateTicket(transformedTicket));
    }

    await for (var ticketState in stream) {
      if (ticketState is TicketDuplicated) {
        tickets.remove(ticketState.ticket);
      }
    }

    add(CreateListOfTicketsEvent(tickets));
  }

  TicketTypeEntity _createTicketForDate(TicketTypeEntity ticket, String date) {
    var [startDateTime, endDateTime] = DateTimeUtils.parseDateTimeRange(date);

    return ticket.copyWith(
      startDate: startDateTime,
      endDate: endDateTime,
      createdAt: DateTime.now(),
    );
  }

  void _onDuplicatedTicketCheck(CheckDuplicateTicket event, emit) async {
    add(GetTicketByNameAndCategoryEvent(
        tourId: event.ticket.tourId,
        name: event.ticket.ticketTypeName,
        category: event.ticket.category.name));

    await for (var ticketState in stream) {
      if (ticketState is TicketActionSuccess) {
        if (ticketState.ticket.ticketTypeName == event.ticket.ticketTypeName &&
            ticketState.ticket.category == event.ticket.category) {
          emit(TicketDuplicated(event.ticket));
        } else {
          emit(TicketUnDuplicated());
        }
      }
    }
  }
}
