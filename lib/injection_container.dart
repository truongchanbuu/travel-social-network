import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_social_network/cores/constants/constants.dart';

final getIt = GetIt.I;

Future<void> initializeDependencies() async {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: baseUrl)));

  // Firebase
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
}
