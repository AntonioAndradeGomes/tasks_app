import 'package:flutter/foundation.dart';
import 'package:frontend/data/repositories/filter/filter_repository.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/dtos/task_dto.dart';
import 'package:frontend/domain/models/filter_model.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/domain/use_case/task/check_or_uncheck_task_use_case.dart';
import 'package:logging/logging.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

/*
Como fazer a ordenação
1- recupera o filtro em um repositorio
2 - salva ele no repositorio de tarefas
3 - faz o get das tarefas no repositorio de tarefas (passando o filtro)
4 - já tenho todas ordenadas
---------
em casos de insert, update e delete, o repositorio de tarefas é o unico que muda
1 - faz o insert no repositorio de tarefas
2 - ordena todas com base no ultimo filtro passado
3 - o mesmo com o update
4 - o delete não precisa ordenar
*/
class HomeViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepository;
  final FilterRepository _filterRepository;
  final CheckOrUncheckTaskUseCase _checkOrUncheckTaskUseCase;

  HomeViewModel({
    required TasksRepository tasksRepository,
    required CheckOrUncheckTaskUseCase checkOrUncheckTaskUseCase,
    required FilterRepository filterRepository,
  })  : _tasksRepository = tasksRepository,
        _filterRepository = filterRepository,
        _checkOrUncheckTaskUseCase = checkOrUncheckTaskUseCase {
    _log.finest('HomeViewModel created');
    _tasksRepository.addListener(_onTasksChanged);
    load = Command0(_load)..execute();
    updateTask = Command1(_updateTask);
    deleteTask = Command1(_deleteTask);
  }

  final _log = Logger('HomeViewModel');

  List<TaskModel> get _tasks => _tasksRepository.tasks;
  bool get tasksIsEmpty => _tasks.isEmpty;
  List<TaskModel> get completedTasks =>
      _tasks.where((task) => task.completedAt != null).toList();
  List<TaskModel> get uncompletedTasks =>
      _tasks.where((task) => task.completedAt == null).toList();

  bool _showCompleted = true;

  bool get showCompleted => _showCompleted;
  set showCompleted(bool value) {
    if (value == _showCompleted) {
      return;
    }
    _showCompleted = value;
    notifyListeners();
  }

  FilterModel? filter;

  late Command0<List<TaskModel>> load;
  late final Command1<TaskModel, TaskModel> updateTask;
  late final Command1<Unit, String> deleteTask;

  AsyncResult<List<TaskModel>> _load() async {
    if (filter == null) {
      final filterResult = await _filterRepository.getFileter();
      filter = filterResult.getOrElse((err) => const FilterModel());
    }
    return _tasksRepository.fetchTasks(filter!);
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

  void setFilter(FilterModel data) {
    _log.finest('Filter: ${data.toString()}');
    filter = data;
    notifyListeners();
    load.execute();
    _filterRepository.saveFilter(data);
  }

  @override
  void dispose() {
    _tasksRepository.removeListener(_onTasksChanged);
    super.dispose();
  }
}
