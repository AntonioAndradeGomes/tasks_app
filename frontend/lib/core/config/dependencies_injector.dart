import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/data/repositories/auth/auth_repository_remote.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository_remote.dart';
import 'package:frontend/data/services/api/auth_api_client.dart';
import 'package:frontend/data/services/api/tasks_api_client.dart';
import 'package:frontend/data/services/shared_preferences_service.dart';
import 'package:frontend/domain/use_case/task/save_task_use_case.dart';
import 'package:frontend/domain/use_case/task/task_show_use_case.dart';
import 'package:frontend/ui/auth/login/view_models/login_view_model.dart';
import 'package:frontend/ui/auth/logout/logout_viewmodel.dart';
import 'package:frontend/ui/auth/signup/view_model/signup_viewmodel.dart';
import 'package:frontend/ui/home/view_model/home_view_model.dart';
import 'package:frontend/ui/task/view_model/show_task_viewmodel.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<AuthApiClient>(AuthApiClient());
  getIt.registerSingleton<SharedPreferencesService>(SharedPreferencesService());
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryRemote(
      apiClient: getIt(),
      sharedPreferencesService: getIt(),
    ),
  );

  getIt.registerSingleton<TasksApiClient>(TasksApiClient());

  getIt.registerSingleton<TasksRepository>(
    TasksRepositoryRemote(
      apiClient: getIt(),
      sharedPreferencesService: getIt(),
    ),
  );

  getIt.registerFactory(
    () => LoginViewModel(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => LogoutViewmodel(
      authRepository: getIt(),
    ),
  );

  getIt.registerFactory(
    () => SignupViewmodel(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => HomeViewModel(
      tasksRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => SaveTaskUseCase(
      repository: getIt(),
    ),
  );

  getIt.registerFactory(
    () => TaskShowUseCase(
      repository: getIt(),
    ),
  );

  getIt.registerFactory(
    () => ShowTaskViewmodel(
      taskShowUseCase: getIt(),
      saveTaskUseCase: getIt(),
    ),
  );
}
