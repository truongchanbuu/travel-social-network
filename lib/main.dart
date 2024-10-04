import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_social_network/features/shared/widgets/app_bottom_navigation_bar.dart';

import './config/themes/app_theme.dart';
import './cores/constants/constants.dart';
import './firebase_options.dart';
import './injection_container.dart';
import 'features/ticket/presentations/bloc/ticket_bloc.dart';
import 'features/tour/presentations/pages/create_tour_page.dart';
import 'generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: themes(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: SafeArea(
        child: Scaffold(
          bottomNavigationBar: const AppBottomNavigationBar(),
          body:
              // CreatedTicketsPage(
              //   tickets: [],
              // )
              // CreatedTicketsPage(tickets: tour1Tickets),
              //     SaveTicketPage(tourId: '001', dates: const [
              //   "14:13 30/09/2024 - 14:13 20/09/2026",
              //   "14:14 30/09/2025 - 14:14 20/09/2026",
              //   "14:13 30/10/2024 - 14:13 20/09/2026",
              //   "14:14 30/11/2024 - 14:14 20/09/2026",
              //   "14:14 30/12/2024 - 14:14 20/09/2026",
              //   "14:14 30/01/2025 - 14:14 20/09/2026"
              // ], selectedDates: [
              //   "14:13 30/09/2024 - 14:13 20/09/2026",
              //   "14:14 30/09/2025 - 14:14 20/09/2026",
              //   "14:13 30/10/2024 - 14:13 20/09/2026",
              // ]),
              BlocProvider(
                  create: (context) => getIt.get<TicketBloc>(),
                  child: CreateTourPage()),
          // HomePage(),
          // AddNumberVisitorPage(ticketId: tour1Tickets.first.ticketTypeId),
          // TourDetailPage(tourId: generateSampleTours()[0].tourId),
          // TicketDetailPage(ticketId: tour1Tickets[0].ticketTypeId),
          // AddTicketTypeItem(ticket: tour1Tickets.first),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const MyApp());
}
