import 'package:flutter/material.dart';
import 'package:frontend/core/config/dependencies_injector.dart';
import 'package:frontend/ui/auth/logout/view_model/logout_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({super.key});

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  late LogoutViewmodel _logoutViewModel;

  @override
  void initState() {
    _logoutViewModel = getIt<LogoutViewmodel>();
    _logoutViewModel.logout.addListener(_resultLogout);
    super.initState();
  }

  @override
  void dispose() {
    _logoutViewModel.logout.removeListener(_resultLogout);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _logoutViewModel.logout,
      builder: (_, child) {
        if (_logoutViewModel.logout.isRunning) {
          return const CircularProgressIndicator();
        }
        return child!;
      },
      child: IconButton(
        icon: const Icon(Icons.logout),
        tooltip: AppLocalizations.of(context)!.logout,
        onPressed: () {
          _logoutViewModel.logout.execute();
        },
      ),
    );
  }

  Future<void> _resultLogout() async {
    if (_logoutViewModel.logout.isFailure) {
      _logoutViewModel.logout.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
