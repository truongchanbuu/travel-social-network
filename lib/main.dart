import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_social_network/features/shared/presentations/widgets/app_bottom_navigation_bar.dart';

import './config/themes/app_theme.dart';
import './cores/constants/constants.dart';
import './firebase_options.dart';
import './injection_container.dart';
import 'features/comment/presentations/bloc/comment_bloc.dart';
import 'features/social/presentations/bloc/post_bloc.dart';
import 'features/social/presentations/pages/social_network_page.dart';
import 'features/tour/presentations/bloc/tour_bloc.dart';
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
      home: BlocProvider(
        create: (context) => getIt.get<TourBloc>(),
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: const AppBottomNavigationBar(),
            body:
                // TODO: CREATED PAGE
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

                //     MultiBlocProvider(providers: [
                //   BlocProvider(create: (context) => getIt.get<TicketBloc>()),
                //   BlocProvider(create: (context) => getIt.get<TourBloc>())
                // ], child: SaveTourPage())
                // HomePage(),
                MultiBlocProvider(providers: [
              BlocProvider(
                  create: (context) =>
                      getIt.get<PostBloc>()..add(GetPostsEvent())),
              BlocProvider(create: (context) => getIt.get<CommentBloc>()),
            ], child: const SocialNetworkPage()),
            //     BlocProvider(
            //   create: (context) => getIt.get<ReviewBloc>(),
            //   child: CreateReviewPage(),
            // )
            // AddNumberVisitorPage(ticketId: tour1Tickets.first.ticketTypeId),
            // TourDetailPage(tourId: generateSampleTours()[0].tourId),
            //     MultiBlocProvider(providers: [
            //   BlocProvider(create: (context) => getIt.get<TicketBloc>()),
            //   BlocProvider(create: (context) => getIt.get<TourBloc>())
            // ], child: YourToursPage()),
            // TicketDetailPage(ticketId: tour1Tickets[0].ticketTypeId),
            // AddTicketTypeItem(ticket: tour1Tickets.first),
          ),
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
