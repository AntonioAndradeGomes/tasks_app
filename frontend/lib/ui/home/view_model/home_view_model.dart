import 'package:flutter/foundation.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/utils/command.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class HomeViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepository;

  HomeViewModel({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository {
    _log.finest('HomeViewModel created');
    load = Command0(_load)..execute();
  }

  final _log = Logger('HomeViewModel');

  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  late Command0 load;

  Future<Result> _load() async {
    try {
      final result = await _tasksRepository.getMyTasks();
      switch (result) {
        case Ok<List<TaskModel>>():
          _tasks = result.value;
          _log.finest('Tasks loaded');
        case Error<List<TaskModel>>():
          _log.warning('Error loading tasks: ${result.error}');
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
