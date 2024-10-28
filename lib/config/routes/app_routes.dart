import "package:flutter/material.dart";
import "package:go_router/go_router.dart" show GoRoute, GoRouter;
import "package:go_transitions/go_transitions.dart";

import "../../features/shared/presentations/pages/home/home_page.dart";
import "../../features/ticket/presentations/pages/save_ticket_page.dart";

var routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    pageBuilder: GoTransitions.slide.toRight.call,
    builder: (_, __) => const HomePage(),
  ),
  GoRoute(
      path: '/tickets',
      pageBuilder: GoTransitions.fadeUpwards.call,
      builder: (_, __) => const Placeholder(),
      routes: [
        GoRoute(
          path: '/create-ticket/:tourId',
          pageBuilder: GoTransitions.bottomSheet.call,
          builder: (context, state) {
            final tourId = state.path![0];
            final extra = state.extra as Map<String, dynamic>?;
            final dates = extra!['dates'] as List<String>;
            final selectedDates = extra['dates'] as List<String>;
            final ticket = extra['ticket'];

            return SaveTicketPage(
              tourId: tourId,
              dates: dates,
              selectedDates: selectedDates,
              ticket: ticket,
            );
          },
        )
      ])
]);
