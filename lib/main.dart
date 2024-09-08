import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './firebase_options.dart';
import './config/themes/app_theme.dart';
import './cores/constants/constants.dart';
import './injection_container.dart';
import 'features/auth/presentation/pages/account_detail_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: themes(),
      home: const SafeArea(
        child: AccountDetailPage(),
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
