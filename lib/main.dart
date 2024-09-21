import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/tickets.dart';
import 'package:travel_social_network/cores/constants/tours.dart';
import 'package:travel_social_network/features/ticket/presentations/pages/add_number_visitor_page.dart';
import 'package:travel_social_network/features/ticket/presentations/pages/ticket_detail_page.dart';
import 'package:travel_social_network/features/ticket/presentations/widgets/add_ticket_type_item.dart';
import 'package:travel_social_network/features/tour/presentation/pages/tour_detail_page.dart';

import './config/themes/app_theme.dart';
import './cores/constants/constants.dart';
import './firebase_options.dart';
import './injection_container.dart';
import 'features/shared/widgets/app_bottom_navigation_bar.dart';
import 'features/shared/widgets/item_counter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: themes(),
      home: SafeArea(
        child: Scaffold(
          bottomNavigationBar: AppBottomNavigationBar(),
          body:
              // AddNumberVisitorPage(ticketId: sampleTickets.first.ticketTypeId),
              // TourDetailPage(tourId: generateSampleTours()[0].tourId),
              // TicketDetailPage(ticketId: sampleTickets[0].ticketTypeId),
              AddTicketTypeItem(ticket: sampleTickets.first),
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
