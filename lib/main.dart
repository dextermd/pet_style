import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style/core/app_bloc_providers.dart';
import 'package:pet_style/core/dependency_injector.dart';
import 'package:pet_style/core/services/storage_services.dart';
import 'package:pet_style/core/theme/app_theme.dart';
import 'package:pet_style/firebase_options.dart';
import 'package:pet_style/view/router/app_router.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Talker и регистрация в GetIt
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);

  // Инициализация Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Инициализация StorageServices
  await StorageServices.init();

  DependencyInjector.setup(talker);

  // Установка BlocObserver для Talker
  Bloc.observer = TalkerBlocObserver(talker: talker);

  // Запуск приложения
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = AppRouter().router;

    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders,
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: AppTheme.whiteThemeMode,
            routerConfig: router,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru'),
              Locale('ro'),
              Locale('en'),
            ],
          );
        },
      ),
    );
  }
}
