import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:travel_social_network/features/auth/presentation/pages/auth_method_page.dart';

import './firebase_options.dart';
import './config/themes/app_theme.dart';
import './cores/constants/constants.dart';
import './injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: themes(),
      home: const SafeArea(
        child: Scaffold(
          bottomNavigationBar: AppBottomNavigationBar(),
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