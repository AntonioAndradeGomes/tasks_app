import 'package:flutter/foundation.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/dtos/task_dto.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/domain/use_case/task/check_or_uncheck_task_use_case.dart';
import 'package:logging/logging.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

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
    updateTask = Command1(_updateTask);
    deleteTask = Command1(_deleteTask);
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

  late Command0<List<TaskModel>> load;
  late final Command1<TaskModel, TaskModel> updateTask;
  late final Command1<Unit, String> deleteTask;

  AsyncResult<List<TaskModel>> _load() {
    return _tasksRepository.fetchTasks();
  }

  AsyncResult<TaskModel> _updateTask(TaskModel task) async {
    final taskDto = TaskDto.fromModel(task);
    return await _checkOrUncheckTaskUseCase(taskDto);
  }

  AsyncResult<Unit> _deleteTask(String id) async {
    return _tasksRepository.deleteTask(id);
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
