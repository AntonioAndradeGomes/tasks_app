import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/routing/app_routes.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  await setupDependencies();
  runApp(
    MyApp(
      appRoutes: AppRoutes(
        repository: getIt<AuthRepository>(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRoutes appRoutes;
  const MyApp({
    super.key,
    required this.appRoutes,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes.router,
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
