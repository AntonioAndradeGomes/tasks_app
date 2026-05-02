import 'package:frontend/modules/tasks/repositories/filter/filter_repository.dart';
import 'package:frontend/modules/tasks/repositories/filter/filter_repository_local.dart';
import 'package:frontend/modules/tasks/repositories/tasks/tasks_repository.dart';
import 'package:frontend/modules/tasks/repositories/tasks/tasks_repository_remote.dart';
import 'package:frontend/modules/tasks/services/filter/filter_local_storage.dart';
import 'package:frontend/modules/tasks/services/tasks/task_client_http.dart';
import 'package:frontend/modules/tasks/use_case/check_or_uncheck_task_use_case.dart';
import 'package:frontend/modules/tasks/use_case/save_task_use_case.dart';
import 'package:frontend/modules/tasks/use_case/task_show_use_case.dart';
import 'package:frontend/modules/tasks/viewmodels/home_view_model.dart';
import 'package:frontend/modules/tasks/viewmodels/show_task_viewmodel.dart';
import 'package:get_it/get_it.dart';

initTasksModule(GetIt getIt) {
  getIt.registerLazySingleton(
    () => FilterLocalStorage(
      localStorageService: getIt(),
    ),
  );

  getIt.registerLazySingleton<FilterRepository>(
    () => FilterRepositoryLocal(
      filterLocalStorage: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => TaskClientHttp(
      clientHttp: getIt(),
    ),
  );

  getIt.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryRemote(
      taskClientHttp: getIt(),
    ),
  );

  getIt.registerLazySingleton<CheckOrUncheckTaskUseCase>(
    () => CheckOrUncheckTaskUseCase(
      repository: getIt(),
    ),
  );

  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(
      tasksRepository: getIt(),
      checkOrUncheckTaskUseCase: getIt(),
      filterRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<TaskShowUseCase>(
    () => TaskShowUseCase(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<SaveTaskUseCase>(
    () => SaveTaskUseCase(
      repository: getIt(),
    ),
  );

  getIt.registerFactory<ShowTaskViewmodel>(
    () => ShowTaskViewmodel(
      taskShowUseCase: getIt(),
      saveTaskUseCase: getIt(),
      tasksRepository: getIt(),
    ),
  );
}
