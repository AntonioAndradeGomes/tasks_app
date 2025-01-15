import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/ui/auth/logout/logout_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LogoutViewmodel _logoutViewModel;

  @override
  void initState() {
    _logoutViewModel = getIt<LogoutViewmodel>();
    _logoutViewModel.logout.addListener(_resultLogout);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newLogoutViewModel = getIt<LogoutViewmodel>();
    if (_logoutViewModel != newLogoutViewModel) {
      _logoutViewModel.logout.removeListener(_resultLogout);
      _logoutViewModel = newLogoutViewModel;
      _logoutViewModel.logout.addListener(_resultLogout);
    }
  }

  @override
  void dispose() {
    _logoutViewModel.logout.removeListener(_resultLogout);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          ListenableBuilder(
            listenable: _logoutViewModel.logout,
            builder: (_, __) {
              if (_logoutViewModel.logout.running) {
                return const CircularProgressIndicator();
              }
              return IconButton(
                onPressed: _logoutViewModel.logout.execute,
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: Container(),
    );
  }

  Future<void> _resultLogout() async {
    if (_logoutViewModel.logout.error) {
      _logoutViewModel.logout.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
