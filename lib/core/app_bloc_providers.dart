import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pet_style/blocs/network_bloc/network_bloc.dart';
import 'package:pet_style/blocs/sign_in/sign_in_bloc.dart';
import 'package:pet_style/blocs/sign_up/sign_up_bloc.dart';
import 'package:pet_style/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:pet_style/blocs/user/user_bloc.dart';
import 'package:pet_style/domain/repository/auth_repository.dart';
import 'package:pet_style/domain/repository/user_repository.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider<OnboardingBloc>(
            lazy: true, create: (context) => OnboardingBloc()),
        BlocProvider<SignInBloc>(
            lazy: true,
            create: (context) => SignInBloc(GetIt.I<AuthRepository>())),
        BlocProvider<SignUpBloc>(
            lazy: true,
            create: (context) => SignUpBloc(GetIt.I<AuthRepository>())),
        BlocProvider<UserBloc>(
            lazy: true,
            create: (context) => UserBloc(GetIt.I<UserRepository>())),
        BlocProvider<NetworkBloc>(
            lazy: true,
            create: (context) => NetworkBloc(connectionChecker:  InternetConnection())),
      ];
}
