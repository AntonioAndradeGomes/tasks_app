import 'package:flutter/foundation.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/domain/use_case/task/save_task_use_case.dart';
import 'package:frontend/domain/use_case/task/task_show_use_case.dart';
import 'package:frontend/utils/command.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class ShowTaskViewmodel extends ChangeNotifier {
  final _log = Logger('ShowTaskViewmodel');
  final TaskShowUseCase _taskShowUseCase;
  final SaveTaskUseCase _saveTaskUseCase;

  ShowTaskViewmodel({
    required TaskShowUseCase taskShowUseCase,
    required SaveTaskUseCase saveTaskUseCase,
  })  : _taskShowUseCase = taskShowUseCase,
        _saveTaskUseCase = saveTaskUseCase {
    _log.finest('HomeViewModel created');
    loadTask = Command1<void, String?>(_load);
    saveTask = Command0<TaskModel>(_save);
  }
  //essa task só vai servir para comparar com _editableTask
  TaskModel? _task;

  TaskModel? _editableTask;

  TaskModel? get task => _editableTask;

  bool get taskWasEdited => _task != _editableTask;

  late final Command1<void, String?> loadTask;
  late final Command0<TaskModel> saveTask;

  Future<Result<void>> _load(String? id) async {
    final result = await _taskShowUseCase.call(id);
    switch (result) {
      case Ok<TaskModel>():
        _log.finest('Task loaded');
        _task = result.value;
        _editableTask = result.value.copyWith();
        notifyListeners();
      case Error<TaskModel>():
        _log.warning('Error loading task: ${result.error}');
    }
    return result;
  }

  Future<Result<TaskModel>> _save() async {
    final result = await _saveTaskUseCase.call(_editableTask!);
    switch (result) {
      case Ok<TaskModel>():
        _log.finest('Task saved');
        _task = result.value;
        _editableTask = result.value.copyWith();
        notifyListeners();
      case Error<TaskModel>():
        _log.warning('Error saving task: ${result.error}');
    }
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
