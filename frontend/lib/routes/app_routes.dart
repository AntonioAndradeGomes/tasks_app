import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/repositories/auth_repository.dart';
import 'package:frontend/modules/tasks/views/home_page.dart';
import 'package:frontend/modules/auth/views/login_page.dart';
import 'package:frontend/routes/routes.dart';
import 'package:frontend/modules/auth/views/signup_page.dart';
import 'package:frontend/modules/splash/views/splash_page.dart';
import 'package:frontend/modules/tasks/views/show_task_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  final AuthRepository repository;
  AppRoutes({
    required this.repository,
  });

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.splash,
    debugLogDiagnostics: true,
    refreshListenable: repository,
    routes: <GoRoute>[
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashPage(),
        redirect: (context, state) {
          if (repository.isAuthenticated == true) {
            return Routes.home;
          }
          if (repository.isAuthenticated == false) {
            return Routes.login;
          }
          return null;
        },
      ),
      GoRoute(
        path: Routes.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
        redirect: (context, state) {
          if (repository.isAuthenticated == true) {
            return Routes.home;
          }
          return null;
        },
      ),
      GoRoute(
        path: Routes.signup,
        builder: (BuildContext context, GoRouterState state) =>
            const SignupPage(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        redirect: (context, state) {
          if (repository.isAuthenticated == null ||
              repository.isAuthenticated == false) {
            return Routes.login;
          }
          return null;
        },
      ),
      GoRoute(
        path: Routes.task,
        builder: (context, state) => const ShowTaskPage(),
        routes: [
          GoRoute(
            path: ':taskId',
            builder: (context, state) {
              final taskId = state.pathParameters['taskId'];
              return ShowTaskPage(
                taskId: taskId,
              );
            },
          ),
        ],
      ),
    ],
  );
}
