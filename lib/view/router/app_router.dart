import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style/core/helpers/log_helper.dart';
import 'package:pet_style/core/services/storage_services.dart';
import 'package:pet_style/view/app/auth/sign_in/sign_in_screen.dart';
import 'package:pet_style/view/app/auth/sign_up/sign_up_screen.dart';
import 'package:pet_style/view/app/chat/chat_screen.dart';
import 'package:pet_style/view/app/error/no_internet_screen.dart';
import 'package:pet_style/view/app/pet_form/pet_form_screen.dart';
import 'package:pet_style/view/app/onboarding/onboarding_screen.dart';
import 'package:pet_style/view/app/home/home_screen.dart';
import 'package:pet_style/view/app/menu/bottom_navigation.dart';
import 'package:pet_style/view/app/schedule/schedule_screen.dart';
import 'package:pet_style/view/app/setting/setting_screen.dart';
import 'package:pet_style/view/app/splash/splash_screen.dart';
import 'package:talker_flutter/talker_flutter.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final bool showOnboarding = StorageServices.getDeviceOnboardingOpen();

class AppRouter {
  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/sign_in',
        name: 'sign_in',
        builder: (context, state) => const SignInScreen(),
        routes: [
          GoRoute(
            path: 'sign_up',
            name: 'sign_up',
            builder: (context, state) => const SignUpScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/no_internet',
        name: 'no_internet',
        builder: (context, state) => NoInternetScreen(
          onRetry: () {
            context.go(state.extra as String? ?? '/');
          },
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => BottomNavigation(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'pet_form',
                name: 'pet_form',
                builder: (context, state) => PetFormScreen(id: state.extra as String?),
                parentNavigatorKey: _shellNavigatorKey,
              ),
            ]
          ),
          GoRoute(
            path: '/schedule',
            name: 'schedule',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ScheduleScreen(),
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: '/setting',
            name: 'setting',
            builder: (context, state) => const SettingScreen(),
          ),
        ],
      )
    ],
    observers: [TalkerRouteObserver(GetIt.I<Talker>())],
    redirect: (context, state) async {
      bool isLoggedIn = StorageServices.getIsLoggedIn();
      logDebug(state.matchedLocation);

      final protectedRoutes = ['/home', '/schedule', '/chat', '/setting'];
      if (!isLoggedIn && protectedRoutes.contains(state.matchedLocation)) {
        return '/sign_in';
      }

      if (state.matchedLocation == '/onboarding' && !showOnboarding) {
        logDebug('isLoggedIn $isLoggedIn');
        logDebug('state.matchedLocation ${state.matchedLocation}');
        if (isLoggedIn && state.matchedLocation == '/onboarding') {
          logDebug('go splash');
          return '/splash';
        } else {
          logDebug('go sign_in');
          return '/sign_in';
        }
      }
      return null;
    },
  );
}
