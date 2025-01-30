import 'package:flutter/foundation.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/dtos/task_dto.dart';
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
  //dto que será editado
  TaskDto? _editableTask;

  TaskDto? get task => _editableTask;
  //comparação do dto com a tarefa
  bool get taskWasEdited => !_editableTask!.equalsModel(_task!);

  late final Command1<void, String?> loadTask;
  late final Command0<TaskModel> saveTask;
  late final Command0<Unit> deleteTask;

  AsyncResult<TaskModel> _load(String? id) async {
    final result = await _taskShowUseCase.call(id);
    result.fold(
      (task) {
        _log.finest('Task loaded');
        _task = task;
        _editableTask = TaskDto.fromModel(task);
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
        _editableTask = TaskDto.fromModel(task);
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

  //edições nos campos de titulo e descrição
  void setTitle(String title) {
    _editableTask?.setTitle(title);
    notifyListeners();
  }

  void setDescription(String description) {
    _editableTask?.setDescription(description);
    notifyListeners();
  }

  void setHexColor(String hexColor) {
    _editableTask?.setHexColor(hexColor);
    notifyListeners();
  }

  void setDueAt(DateTime? dueAt) {
    _editableTask?.setDueAt(dueAt);
    notifyListeners();
  }

  void setCompletedAt() {
    if (_editableTask?.completedAt != null) {
      _editableTask?.setCompletedAt(null);
    } else {
      _editableTask?.setCompletedAt(DateTime.now());
    }
    notifyListeners();
  }
}
