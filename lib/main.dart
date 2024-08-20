import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/constants.dart';
import 'package:travel_social_network/firebase_options.dart';
import 'package:travel_social_network/injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      home: SafeArea(
        child: Placeholder(),
      ),
    );
  }
}

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const MyApp());
}
