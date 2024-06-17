import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pet_style/core/services/interceptors/auth_interceptor.dart';
import 'package:pet_style/data/repository/auth_repository_impl.dart';
import 'package:pet_style/data/repository/user_repository_impl.dart';
import 'package:pet_style/domain/repository/auth_repository.dart';
import 'package:pet_style/domain/repository/user_repository.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DependencyInjector {
  static final GetIt _getIt = GetIt.instance;

  static void setup(Talker talker) {
    final dio = Dio();
    dio.interceptors.add(TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestData: false,
        )));

    _getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(dio: dio));

    _getIt.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(dio: dio));

    _getIt.registerLazySingleton<InternetConnection>(
        () => InternetConnection());

    dio.interceptors.add(AuthInterceptor(dio: dio));
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
