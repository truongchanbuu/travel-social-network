import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/themes/app_theme.dart';
import 'cores/constants/constants.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentations/bloc/auth_bloc.dart';
import 'features/comment/presentations/bloc/comment_bloc.dart';
import 'features/setting/presentations/cubit/settings_cubit.dart';
import 'features/shared/presentations/pages/home/container_page_with_bottom_nav.dart';
import 'features/social/presentations/bloc/post_bloc.dart';
import 'features/tour/presentations/bloc/tour_bloc.dart';
import 'features/user/presentations/bloc/user_cubit.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  final AuthRepository authenticationRepository;

  const MyApp({super.key, required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt.get<AuthBloc>()..add(AuthUserSubscriptionRequest()),
        ),
        BlocProvider(create: (_) => getIt.get<UserCubit>()),
        BlocProvider(create: (_) => getIt.get<SettingsCubit>()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      themeMode: context.select((SettingsCubit settings) =>
          settings.isDarkMode ? ThemeMode.dark : ThemeMode.light),
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      locale:
          context.select((SettingsCubit settings) => settings.currentLocale),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt.get<TourBloc>()),
          BlocProvider(
            create: (context) => getIt.get<PostBloc>()..add(GetPostsEvent()),
          ),
          BlocProvider(create: (context) => getIt.get<CommentBloc>()),
        ],
        child: const ContainerPageWithBottomNav(),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();

  final authenticationRepository = getIt.get<AuthRepository>();
  runApp(MyApp(authenticationRepository: authenticationRepository));
}
