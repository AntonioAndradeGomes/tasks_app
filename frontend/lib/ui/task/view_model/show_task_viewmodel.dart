import 'package:flutter/foundation.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/domain/use_case/task/save_task_use_case.dart';
import 'package:frontend/domain/use_case/task/task_show_use_case.dart';
import 'package:logging/logging.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class ShowTaskViewmodel extends ChangeNotifier {
  final _log = Logger('ShowTaskViewmodel');
  final TaskShowUseCase _taskShowUseCase;
  final SaveTaskUseCase _saveTaskUseCase;
  final TasksRepository _tasksRepository;

  ShowTaskViewmodel({
    required TaskShowUseCase taskShowUseCase,
    required SaveTaskUseCase saveTaskUseCase,
    required TasksRepository tasksRepository,
  })  : _taskShowUseCase = taskShowUseCase,
        _saveTaskUseCase = saveTaskUseCase,
        _tasksRepository = tasksRepository {
    _log.finest('HomeViewModel created');
    loadTask = Command1(_load);
    saveTask = Command0(_save);
    deleteTask = Command0(_delete);
  }
  //essa task só vai servir para comparar com _editableTask
  TaskModel? _task;

  TaskModel? _editableTask;

  TaskModel? get task => _editableTask;

  bool get taskWasEdited => _task != _editableTask;

  late final Command1<void, String?> loadTask;
  late final Command0<TaskModel> saveTask;
  late final Command0<Unit> deleteTask;

  AsyncResult<TaskModel> _load(String? id) async {
    final result = await _taskShowUseCase.call(id);
    result.fold(
      (task) {
        _log.finest('Task loaded');
        _task = task;
        _editableTask = task.copyWith();
        notifyListeners();
      },
      (error) {
        _log.warning('Error loading task: $error');
      },
    );

    return result;
  }

  AsyncResult<TaskModel> _save() async {
    final result = await _saveTaskUseCase.call(_editableTask!);
    result.fold(
      (task) {
        _log.finest('Task saved');
        _task = task;
        _editableTask = task.copyWith();
        notifyListeners();
      },
      (error) {
        _log.warning('Error saving task: $error');
      },
    );

    return result;
  }

  AsyncResult<Unit> _delete() async {
    final result = await _tasksRepository.deleteTask(_editableTask!.id!);
    result.fold(
      (unit) {
        _log.finest('Task deleted');
      },
      (error) {
        _log.warning('Error deleting task: $error');
      },
    );
    return result;
  }

  //para os casos de alteração no título e na descrição
  void updateTask(TaskModel task) {
    _editableTask = task;
    notifyListeners();
  }

  //para quando se alterar a data de conclusão
  void updateDueDate(DateTime? dueDate) {
    _editableTask!.dueAt = dueDate;
    notifyListeners();
  }

  //check no botão de completar a tarefa
  void completeTask() {
    if (_editableTask!.completedAt == null) {
      _editableTask!.completedAt = DateTime.now();
    } else {
      _editableTask!.completedAt = null;
    }
    notifyListeners();
  }
}
