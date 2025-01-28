import 'package:flutter/foundation.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/domain/use_case/task/check_or_uncheck_task_use_case.dart';
import 'package:frontend/utils/command.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class HomeViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepository;
  final CheckOrUncheckTaskUseCase _checkOrUncheckTaskUseCase;

  HomeViewModel({
    required TasksRepository tasksRepository,
    required CheckOrUncheckTaskUseCase checkOrUncheckTaskUseCase,
  })  : _tasksRepository = tasksRepository,
        _checkOrUncheckTaskUseCase = checkOrUncheckTaskUseCase {
    _log.finest('HomeViewModel created');
    _tasksRepository.addListener(_onTasksChanged);
    load = Command0(_load)..execute();
    updateTask = Command1<void, TaskModel>(_updateTask);
    deleteTask = Command1<void, String>(_deleteTask);
  }

  final _log = Logger('HomeViewModel');

  List<TaskModel> get tasks => _tasksRepository.tasks;
  List<TaskModel> get completedTasks =>
      tasks.where((task) => task.completedAt != null).toList();
  List<TaskModel> get uncompletedTasks =>
      tasks.where((task) => task.completedAt == null).toList();

  bool _showCompleted = true;
  bool get showCompleted => _showCompleted;
  set showCompleted(bool value) {
    if (value == _showCompleted) {
      return;
    }
    _showCompleted = value;
    notifyListeners();
  }

  late Command0 load;
  late final Command1<void, TaskModel> updateTask;
  late final Command1<void, String> deleteTask;

  Future<Result> _load() async {
    try {
      final result = await _tasksRepository.fetchTasks();
      switch (result) {
        case Ok<List<TaskModel>>():
          _log.finest('Tasks loaded');
        case Error<List<TaskModel>>():
          _log.warning('Error loading tasks: ${result.error}');
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _updateTask(TaskModel task) async {
    try {
      final result = await _checkOrUncheckTaskUseCase.call(task);
      switch (result) {
        case Ok<TaskModel>():
          _log.finest('Task updated');
        case Error<TaskModel>():
          _log.warning('Error updating task: ${result.error}');
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _deleteTask(String id) async {
    try {
      final result = await _tasksRepository.deleteTask(id);
      switch (result) {
        case Ok<void>():
          _log.finest('Task deleted');
        case Error<void>():
          _log.warning('Error deleting task: ${result.error}');
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  void _onTasksChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _tasksRepository.removeListener(_onTasksChanged);
    super.dispose();
  }
}
