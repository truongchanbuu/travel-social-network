import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'cores/constants/constants.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentations/bloc/auth_bloc.dart';
import 'features/setting/presentations/cubit/settings_cubit.dart';
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
      home: FlowBuilder<AuthStatus>(
        state: context.select((AuthBloc bloc) => bloc.state.status),
        onGeneratePages: onGeneratePages,
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
