import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/tours.dart';
import 'package:travel_social_network/features/tours/presentation/pages/media_view_page.dart';

import './config/themes/app_theme.dart';
import './cores/constants/constants.dart';
import './firebase_options.dart';
import './injection_container.dart';
import 'cores/shared/widgets/app_bottom_navigation_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // TODO: Add the view of list of images and videos
  // TODO: Change the tickets UI -> Need to make a bottom sheet for it and add a model for ticket
  // TODO: Tour Schedule UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: themes(),
      home: SafeArea(
        child: Scaffold(
          bottomNavigationBar: const AppBottomNavigationBar(),
          // body: TourDetailPage(tour: generateSampleTours()[1]),
          body: MediaViewPage(
            tourId: generateSampleTours()[0].tourId,
            tourName: generateSampleTours()[0].tourName,
            imageUrls: generateSampleTours()[0].imageUrls,
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
