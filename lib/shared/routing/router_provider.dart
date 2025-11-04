import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_task_app/features/login/providers/login_provider.dart';
import 'package:my_task_app/features/login/ui/login_screen.dart';
import 'package:my_task_app/features/task_list/ui/task_list_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final loginState = ref.watch(loginProvider);

  final loginListenable = ValueNotifier<LoginState>(loginState);
  ref.listen(loginProvider, (previous, next) {
    loginListenable.value = next;
  });

  return GoRouter(
    refreshListenable: loginListenable,
    initialLocation: '/login',
    
    // 4. Define all your routes
    routes: [
      // GoRoute(
      //   path: '/splash',
      //   builder: (context, state) => const SplashScreen(),
      // ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => TaskListScreen(),
      ),
    ],

    // 5. The REDIRECT logic
    redirect: (context, state) {
      final isAuthenticated = (loginState.status == AuthStatus.authenticated);
      final isAuthenticating = (loginState.status == AuthStatus.loading);
      final location = state.matchedLocation;

      if (isAuthenticating) {
        return '/login';
      }

      // If NOT authenticated and NOT on the login page, go to login
      if (!isAuthenticated && location != '/login') {
        return '/login';
      }

      // If IS authenticated and on login/splash, go to home
      if (isAuthenticated && (location == '/login' || location == '/splash')) {
        return '/home';
      }
      
      // No redirect needed
      return null;
    },
  );
}