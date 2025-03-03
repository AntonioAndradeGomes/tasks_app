import 'package:flutter/material.dart';
import 'package:frontend/data/exceptions/http_unauthorized_exception.dart';
import 'package:result_command/result_command.dart';
import '../data/repositories/auth/auth_repository.dart';

class MyAppViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  bool expired = false;

  MyAppViewmodel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    Command.setObserverListener((state) {
      commandObserverListener(state);
    });
  }

  commandObserverListener(CommandState<Object> state) async {
    if (state is FailureCommand) {
      if (state.error is HttpUnauthorizedException) {
        final logout = await _authRepository.logout();
        if (logout.isSuccess()) {
          expired = true;
          notifyListeners();
          expired = false;
        }
      }
    }
  }
}
