import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import 'cores/constants/constants.dart';
import 'features/policy/data/repositories/policy_repository_impl.dart';
import 'features/policy/domain/repositories/policy_repository.dart';
import 'features/policy/presentations/bloc/policy_bloc.dart';
import 'features/review/data/repositories/review_repository_impl.dart';
import 'features/review/domain/repositories/review_repository.dart';
import 'features/review/presentations/bloc/review_bloc.dart';
import 'features/shared/data/repositories/image_repository_impl.dart';
import 'features/shared/domain/repositories/image_repository.dart';
import 'features/social/presentations/bloc/post_bloc.dart';
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
  getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);

  // Repository
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerSingleton<TourRepository>(TourRepositoryImpl());
  getIt.registerSingleton<TicketRepository>(TicketRepositoryImpl());
  getIt.registerSingleton<PolicyRepository>(PolicyRepositoryImpl());
  getIt.registerSingleton<ReviewRepository>(ReviewRepositoryImpl());

  // Bloc
  getIt.registerFactory<TourBloc>(() => TourBloc(
        tourRepository: getIt(),
        imageRepository: getIt(),
      ));
  getIt.registerFactory<TicketBloc>(() => TicketBloc(getIt()));
  getIt.registerFactory<PolicyBloc>(() => PolicyBloc(getIt()));
  getIt.registerFactory<ReviewBloc>(() => ReviewBloc(
        tourBloc: getIt(),
        imageRepository: getIt(),
        reviewRepository: getIt(),
      ));
  getIt.registerFactory<PostBloc>(() => PostBloc());
}
