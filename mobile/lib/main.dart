import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/main_module.dart';
import 'package:frontend/modules/auth/repositories/auth_repository.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:frontend/modules/auth/viewmodels/my_app_viewmodel.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  //garante que você pode usar APIs assíncronas antes do runApp.
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

class MyApp extends StatefulWidget {
  final AppRoutes appRoutes;
  const MyApp({
    super.key,
    required this.appRoutes,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: widget.appRoutes.router,
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // Inglês
        Locale('pt', 'BR'),
      ],
      //Envolve tudo dentro de MyAppWidget, que escuta o MyAppViewmodel.
      builder: (context, child) {
        return MyAppWidget(
          child: child!,
        );
      },
    );
  }
}

class MyAppWidget extends StatefulWidget {
  final Widget child;
  const MyAppWidget({
    super.key,
    required this.child,
  });

  @override
  State<MyAppWidget> createState() => _MyAppWidgetState();
}

class _MyAppWidgetState extends State<MyAppWidget> {
  final _myappViewmodel = getIt<MyAppViewmodel>();

  @override
  void initState() {
    _myappViewmodel.addListener(_showSnackbar);
    super.initState();
  }

  @override
  void dispose() {
    _myappViewmodel.removeListener(_showSnackbar);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }

  _showSnackbar() {
    if (_myappViewmodel.expired) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Session expired'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
