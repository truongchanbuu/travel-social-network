import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'cores/constants/constants.dart';
import 'cores/utils/cached_client.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentations/bloc/auth_bloc.dart';
import 'features/auth/presentations/bloc/login/login_cubit.dart';
import 'features/auth/presentations/bloc/signup/signup_cubit.dart';
import 'features/comment/data/repositories/comment_repository_impl.dart';
import 'features/comment/domain/repositories/comment_repository.dart';
import 'features/comment/presentations/bloc/comment_bloc.dart';
import 'features/policy/data/repositories/policy_repository_impl.dart';
import 'features/policy/domain/repositories/policy_repository.dart';
import 'features/policy/presentations/bloc/policy_bloc.dart';
import 'features/review/data/repositories/review_repository_impl.dart';
import 'features/review/domain/repositories/review_repository.dart';
import 'features/review/presentations/bloc/review_bloc.dart';
import 'features/shared/data/repositories/image_repository_impl.dart';
import 'features/shared/domain/repositories/image_repository.dart';
import 'features/social/data/repositories/post_repository_impl.dart';
import 'features/social/domain/repositories/post_repository.dart';
import 'features/social/presentations/bloc/post_bloc.dart';
import 'features/ticket/data/repositories/ticket_repository_impl.dart';
import 'features/ticket/domain/repositories/ticket_repository.dart';
import 'features/ticket/presentations/bloc/ticket_bloc.dart';
import 'features/tour/data/repositories/tour_repository_impl.dart';
import 'features/tour/domain/repositories/tour_repository.dart';
import 'features/tour/presentations/bloc/tour_bloc.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/presentations/bloc/user_cubit.dart';

final getIt = GetIt.I;

Future<void> initializeDependencies() async {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: baseUrl)));

  // SharedPreference
  getIt.registerSingleton<CacheClient>(CacheClient());

  // Google
  getIt.registerFactory<GoogleSignIn>(() => GoogleSignIn.standard());

  // Firebase
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);

  // Repository
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl());
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerSingleton<TourRepository>(TourRepositoryImpl());
  getIt.registerSingleton<TicketRepository>(TicketRepositoryImpl());
  getIt.registerSingleton<PolicyRepository>(PolicyRepositoryImpl());
  getIt.registerSingleton<ReviewRepository>(ReviewRepositoryImpl());
  getIt.registerSingleton<PostRepository>(PostRepositoryImpl());
  getIt.registerSingleton<CommentRepository>(CommentRepositoryImpl());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(
    firebaseAuth: getIt(),
    cache: getIt(),
    googleSignIn: getIt(),
    userRepository: getIt(),
  ));

  // Bloc
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt()));
  getIt.registerFactory<TourBloc>(() => TourBloc(getIt()));
  getIt.registerFactory<TicketBloc>(() => TicketBloc(getIt()));
  getIt.registerFactory<PolicyBloc>(() => PolicyBloc(getIt()));
  getIt.registerFactory<ReviewBloc>(() => ReviewBloc(
        tourBloc: getIt(),
        reviewRepository: getIt(),
      ));
  getIt.registerFactory<PostBloc>(() => PostBloc(getIt()));
  getIt.registerFactory<CommentBloc>(() => CommentBloc(getIt()));

  // Cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
  getIt.registerFactory<UserCubit>(() => UserCubit(getIt()));
}
