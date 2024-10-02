import '../../../../generated/l10n.dart';
import '../../../policy/data/models/policy.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../data/models/ticket_type.dart';
import '../bloc/ticket_bloc.dart';

class TicketCreationCoordinator {
  final TicketBloc ticketBloc;
  final PolicyBloc policyBloc;

  const TicketCreationCoordinator({
    required this.policyBloc,
    required this.ticketBloc,
  });

  Future<String> createPolicyAndTickets(
      List<Policy> policies, List<TicketType> tickets) async {
    policyBloc.add(CreateListOfPolicyEvent(policies));

    await for (var state in policyBloc.stream) {
      if (state is PolicyCreateSuccess) {
        ticketBloc.add(CreateListOfTicketEvent(tickets));
        break;
      } else if (state is PolicyCreateFailure) {
        return S.current.saveError(
            '${S.current.refundPolicy} / ${S.current.reschedulePolicy}');
      }
    }

    await for (var state in ticketBloc.stream) {
      if (state is ListOfTicketSaveSuccess) {
        return S.current.success;
      } else if (state is TicketSaveFailure) {
        return S.current.saveError(S.current.tickets);
      }
    }

    return 'loading';
  }
}
