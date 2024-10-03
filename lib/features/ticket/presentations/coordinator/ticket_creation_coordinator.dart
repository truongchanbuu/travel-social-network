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
    policyBloc.add(CreateListOfPoliciesEvent(policies));

    await for (var state in policyBloc.stream) {
      if (state is ListOfPolicyCreateSuccess) {
        ticketBloc.add(CreateListOfTicketsEvent(tickets));
        break;
      } else if (state is PolicyFailure) {
        return S.current.saveError(
            '${S.current.refundPolicy} / ${S.current.reschedulePolicy}');
      }
    }

    await for (var state in ticketBloc.stream) {
      if (state is ListOfTicketSaveSuccess) {
        return S.current.success;
      } else if (state is TicketFailure) {
        return S.current.saveError(S.current.tickets);
      }
    }

    return 'loading';
  }
}
