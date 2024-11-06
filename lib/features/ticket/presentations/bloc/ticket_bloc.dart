import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/enums/ticket_category.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../cores/utils/enum_utils.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/ticket_type.dart';
import '../../domain/entities/ticket_type.dart';
import '../../domain/repositories/ticket_repository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository ticketRepository;

  TicketBloc(this.ticketRepository) : super(TicketInitial()) {
    on<InitialNewTicketEvent>(_onInitTicket);
    on<GetTicketByIdEvent>(_onGetTicketById);
    on<CreateTicketEvent>(_onCreateTicket);
    on<CreateListOfTicketsEvent>(_onCreateListOfTickets);
    on<UpdateTicketEvent>(_onUpdateTicket);
    on<DeleteTicketEvent>(_onDeleteTicket);
    on<GetAllTicketsByTourId>(_onGetAllTicketsByTourId);
    on<UpdateTicketFieldEvent>(_onUpdateTicketField);
    on<GenerateListOfTicketsEvent>(_onGenerateListOfTickets);
    on<DeleteTourTicketByDateEvent>(_onDeleteTourTicketByDate);
    on<UpdateListOfTicketsEvent>(_onUpdateListOfTickets);
    on<GetTicketsByDate>(_onGetTicketsByDate);
  }

  void _onInitTicket(event, emit) {
    final newTicket = TicketTypeEntity.init(tourId: event.tourId);
    emit(TicketLoaded(TicketType.fromEntity(newTicket)));
  }

  Future<void> _onGetTicketById(GetTicketByIdEvent event, emit) async {
    try {
      final dataState = await ticketRepository.getTicketById(event.ticketId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TicketFailure(S.current.dataStateFailure));
      } else {
        emit(TicketLoaded(dataState.data!));
      }
    } catch (e) {
      log(e.toString());
      emit(TicketFailure(S.current.dataStateFailure));
    }
  }

  Future<void> _onCreateTicket(event, emit) async {
    try {
      final dataState = await ticketRepository.createTicket(event.ticket);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TicketFailure(S.current.dataStateFailure));
      } else {
        emit(TicketLoaded(dataState.data!));
      }
    } catch (e) {
      log(e.toString());
      emit(TicketFailure(S.current.dataStateFailure));
    }
  }

  Future<void> _onCreateListOfTickets(
      CreateListOfTicketsEvent event, Emitter<TicketState> emit) async {
    try {
      final dataState = await ticketRepository
          .createTickets(event.tickets.map(TicketType.fromEntity).toList());

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TicketFailure(S.current.dataStateFailure));
      } else {
        emit(ListOfTicketsSuccess(
            dataState.data!.map((ticket) => ticket.toEntity()).toList()));
      }
    } catch (e) {
      log('Failed to create tickets: $e');
      emit(TicketFailure(S.current.dataStateFailure));
    }
  }

  Future<void> _onUpdateTicket(
      UpdateTicketEvent event, Emitter<TicketState> emit) async {
    if (!_isTicketChanged(event.oldTicket, event.newTicket)) {
      emit(TicketActionSuccess(event.oldTicket));
    } else {
      try {
        final dataState = await ticketRepository.updateTicket(
          event.oldTicket.ticketTypeId,
          TicketType.fromEntity(event.newTicket),
        );

        if (dataState is DataFailure) {
          log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
          emit(TicketFailure(dataState.error?.message ??
              'ERROR OCCURRED: ${dataState.error}'));
        } else {
          emit(TicketActionSuccess(dataState.data!.toEntity()));
        }
      } catch (e) {
        log(e.toString());
        emit(TicketFailure(S.current.dataStateFailure));
      }
    }
  }

  bool _isTicketChanged(
    TicketTypeEntity oldTicket,
    TicketTypeEntity newTicket,
  ) {
    return newTicket.ticketTypeName != oldTicket.ticketTypeName ||
        newTicket.ticketDescription != oldTicket.ticketDescription ||
        newTicket.redemptionMethodDesc != oldTicket.redemptionMethodDesc ||
        newTicket.ticketInfo != oldTicket.ticketInfo ||
        newTicket.category != oldTicket.category ||
        newTicket.ticketPrice != oldTicket.ticketPrice ||
        newTicket.quantity != oldTicket.quantity ||
        newTicket.refundPolicyId != oldTicket.refundPolicyId ||
        newTicket.reschedulePolicyId != oldTicket.reschedulePolicyId;
  }

  Future<void> _onGetAllTicketsByTourId(event, emit) async {
    try {
      final dataState =
          await ticketRepository.getAllTicketsByTourId(event.tourId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TicketFailure(S.current.dataStateFailure));
      } else {
        emit(ListOfTicketsLoaded(
            dataState.data!.map((data) => data.toEntity()).toList()));
      }
    } catch (e) {
      log(e.toString());
      emit(TicketFailure(S.current.dataStateFailure));
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
      case TicketTypeEntity.ticketTypeNameFieldName:
        return ticket.copyWith(ticketTypeName: value.toString());
      case TicketTypeEntity.ticketPriceFieldName:
        return ticket.copyWith(ticketPrice: value as num);
      case TicketTypeEntity.quantityFieldName:
        return ticket.copyWith(quantity: value as int);
      case TicketTypeEntity.categoryFieldName:
        return ticket.copyWith(
            category: stringToEnum(value as String, TicketCategory.values));
      case TicketTypeEntity.ticketDescriptionFieldName:
        return ticket.copyWith(ticketDescription: value.toString());
      case TicketTypeEntity.ticketInfoFieldName:
        return ticket.copyWith(ticketInfo: value.toString());
      case TicketTypeEntity.redemptionMethodDescFieldName:
        return ticket.copyWith(redemptionMethodDesc: value.toString());
      case TicketTypeEntity.refundPolicyIdFieldName:
        return ticket.copyWith(refundPolicyId: value.toString());
      case TicketTypeEntity.reschedulePolicyIdFieldName:
        return ticket.copyWith(reschedulePolicyId: value.toString());
      default:
        return ticket;
    }
  }

  void _onGenerateListOfTickets(
      GenerateListOfTicketsEvent event, Emitter<TicketState> emit) async {
    List<TicketTypeEntity> validTickets = [];
    List<TicketTypeEntity> duplicatedTickets = [];

    for (var rangeDate in event.selectedRangeDates) {
      final TicketTypeEntity createdTicket =
          _createTicketForDate(event.ticket, rangeDate);

      bool isDuplicated =
          await _checkDuplicated(TicketType.fromEntity(createdTicket));

      if (isDuplicated) {
        duplicatedTickets.add(createdTicket);
      } else {
        validTickets.add(createdTicket);
      }
    }

    emit(TicketsGenerated(
      validTickets: validTickets,
      invalidTickets: duplicatedTickets,
    ));

    emit(TicketLoaded(TicketType.fromEntity(event.ticket)));
  }

  TicketTypeEntity _createTicketForDate(TicketTypeEntity ticket, String date) {
    var [startDateTime, endDateTime] = DateTimeUtils.parseDateTimeRange(date);

    return ticket.copyWith(
      ticketTypeId: 'TICKET-${const Uuid().v4()}',
      startDate: startDateTime,
      endDate: endDateTime,
      createdAt: DateTime.now(),
    );
  }

  Future<bool> _checkDuplicated(TicketType ticket) async {
    try {
      final dataState =
          await ticketRepository.getTourTicketWithNameAndCategoryInDate(
        tourId: ticket.tourId,
        name: ticket.ticketTypeName,
        category: ticket.category.name,
        startDate: ticket.startDate,
        endDate: ticket.endDate,
      );

      return dataState is DataSuccess && dataState.data != null;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> _onDeleteTicket(
      DeleteTicketEvent event, Emitter<TicketState> emit) async {
    try {
      final dataState = await ticketRepository.deleteTicketById(event.ticketId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TicketFailure(S.current.dataStateFailure));
      } else {
        emit(TicketDeleted(dataState.data!.toEntity()));
      }
    } catch (e) {
      log(e.toString());
      emit(TicketFailure(S.current.dataStateFailure));
    }
  }

  Future<void> _onDeleteTourTicketByDate(
      DeleteTourTicketByDateEvent event, emit) async {
    try {
      final dataState =
          await ticketRepository.getAllTicketsByTourId(event.tourId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TicketFailure(S.current.dataStateFailure));
      } else {
        final tickets = dataState.data!;
        final [startDate, endDate] =
            DateTimeUtils.parseDateTimeRange(event.rangeDate);

        if (tickets.isNotEmpty) {
          final desiredTickets = tickets
              .where((ticket) =>
                  DateTimeUtils.isSameDate(ticket.startDate, startDate) &&
                  DateTimeUtils.isSameDate(ticket.endDate, endDate))
              .toList();

          for (var ticket in desiredTickets) {
            await ticketRepository.deleteTicketById(ticket.ticketTypeId);
            tickets.remove(ticket);
            emit(TicketDeleted(ticket));
          }
        }

        emit(ListOfTicketsLoaded(tickets));
      }
    } catch (e) {
      log(e.toString());
      emit(TicketFailure(S.current.dataStateFailure));
    }
  }

  void _onUpdateListOfTickets(UpdateListOfTicketsEvent event, emit) {
    if (event.tickets.isNotEmpty) {
      emit(ListOfTicketsLoaded(event.tickets));
    }
  }

  Future<void> _onGetTicketsByDate(GetTicketsByDate event, emit) async {
    try {
      final dataState = await ticketRepository.getTicketsByDate(
        tourId: event.tourId,
        startDate: event.startDate,
      );

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(TicketFailure(S.current.dataStateFailure));
      } else {
        emit(ListOfTicketsLoaded(
            dataState.data!.map((ticket) => ticket.toEntity()).toList()));
      }
    } catch (e) {
      log(e.toString());
      emit(TicketFailure(S.current.dataStateFailure));
    }
  }
}
