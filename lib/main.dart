import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_social_network/features/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:travel_social_network/features/tour/presentation/pages/create_tour_page.dart';

import './config/themes/app_theme.dart';
import './cores/constants/constants.dart';
import './firebase_options.dart';
import './injection_container.dart';
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
          bottomNavigationBar: AppBottomNavigationBar(),
          body: CreateTourPage(),
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
