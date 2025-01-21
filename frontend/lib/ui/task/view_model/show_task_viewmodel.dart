import 'package:flutter/foundation.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/domain/use_case/task_show_use_case.dart';
import 'package:frontend/utils/command.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class ShowTaskViewmodel extends ChangeNotifier {
  final _log = Logger('ShowTaskViewmodel');
  final TaskShowUseCase _taskShowUseCase;

  ShowTaskViewmodel({
    required TaskShowUseCase taskShowUseCase,
  }) : _taskShowUseCase = taskShowUseCase {
    _log.finest('HomeViewModel created');
    loadTask = Command1<void, String?>(_load);
  }
  //essa task só vai servir para comparar com _editableTask
  TaskModel? _task;

  TaskModel? _editableTask;

  TaskModel? get task => _editableTask;

  bool get taskWasEdited => _task != _editableTask;

  late final Command1<void, String?> loadTask;

  Future<Result<void>> _load(String? id) async {
    final result = await _taskShowUseCase.call(id);
    switch (result) {
      case Ok<TaskModel>():
        _log.finest('Task loaded');
        _task = result.value;
        _editableTask = result.value;
        notifyListeners();
      case Error<TaskModel>():
        _log.warning('Error loading task: ${result.error}');
    }
    return result;
  }

  void updateTask(TaskModel task) {
    _editableTask = task;
    notifyListeners();
  }

  void updateDueDate(DateTime? dueDate) {
    _editableTask = _editableTask!.taskWithDueAt(dueDate);
    notifyListeners();
  }

  void completeTask() {
    if (_editableTask!.completedAt == null) {
      _editableTask = _editableTask!.copyWith(completedAt: DateTime.now());
    } else {
      _editableTask = _editableTask!.taskWithChecked(null);
    }
    notifyListeners();
  }
}
