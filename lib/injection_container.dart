import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'cores/constants/constants.dart';
import 'features/policy/data/repositories/policy_repository_impl.dart';
import 'features/policy/domain/repositories/policy_repository.dart';
import 'features/policy/presentations/bloc/policy_bloc.dart';
import 'features/ticket/data/repositories/ticket_repository_impl.dart';
import 'features/ticket/domain/repositories/ticket_repository.dart';
import 'features/ticket/presentations/bloc/ticket_bloc.dart';
import 'features/tour/data/repositories/tour_repository_impl.dart';
import 'features/tour/domain/repositories/tour_repository.dart';
import 'features/tour/presentations/bloc/tour_bloc.dart';

final getIt = GetIt.I;

Future<void> initializeDependencies() async {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: baseUrl)));

  // Firebase
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Repository
  getIt.registerSingleton<TourRepository>(TourRepositoryImpl());
  getIt.registerSingleton<TicketRepository>(TicketRepositoryImpl());
  getIt.registerSingleton<PolicyRepository>(PolicyRepositoryImpl());

  // Bloc
  getIt.registerFactory<TourBloc>(() => TourBloc(getIt()));
  getIt.registerFactory<TicketBloc>(() => TicketBloc(getIt()));
  getIt.registerFactory<PolicyBloc>(() => PolicyBloc(getIt()));
}
