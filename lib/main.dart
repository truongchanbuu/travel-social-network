import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/tours.dart';
import 'package:travel_social_network/features/tours/presentation/widgets/tour/available_date_list.dart';

import './config/themes/app_theme.dart';
import './cores/constants/constants.dart';
import './firebase_options.dart';
import './injection_container.dart';
import 'cores/shared/widgets/app_bottom_navigation_bar.dart';
import 'features/tours/presentation/pages/tour_detail_page.dart';

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
          bottomNavigationBar: const AppBottomNavigationBar(),
          body: TourDetailPage(tour: generateSampleTours()[0]),
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
