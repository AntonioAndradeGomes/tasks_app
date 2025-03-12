import 'package:dio/dio.dart';
import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/data/repositories/auth/auth_repository_remote.dart';
import 'package:frontend/data/repositories/filter/filter_repository.dart';
import 'package:frontend/data/repositories/filter/filter_repository_local.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository_remote.dart';
import 'package:frontend/data/services/auth/auth_client_http.dart';
import 'package:frontend/data/services/auth/auth_local_storage.dart';
import 'package:frontend/data/services/auth/interceptor/auth_interceptor.dart';
import 'package:frontend/data/services/client_http.dart';
import 'package:frontend/data/services/local_storage_service.dart';
import 'package:frontend/data/services/filter/filter_local_storage.dart';
import 'package:frontend/data/services/tasks/task_client_http.dart';
import 'package:frontend/domain/use_case/task/check_or_uncheck_task_use_case.dart';
import 'package:frontend/domain/use_case/task/save_task_use_case.dart';
import 'package:frontend/domain/use_case/task/task_show_use_case.dart';
import 'package:frontend/ui/auth/login/view_models/login_view_model.dart';
import 'package:frontend/ui/auth/logout/view_model/logout_viewmodel.dart';
import 'package:frontend/ui/auth/signup/view_model/signup_viewmodel.dart';
import 'package:frontend/ui/home/view_model/home_view_model.dart';
import 'package:frontend/ui/my_app_viewmodel.dart';
import 'package:frontend/ui/task/view_model/show_task_viewmodel.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<Dio>(
    () => Dio(),
  );

  getIt.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(
      authLocalStorage: getIt(),
    ),
  );

  getIt.registerLazySingleton<ClientHttp>(
    () => ClientHttp(
      dio: getIt(),
      authInterceptor: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthClientHttp>(
    () => AuthClientHttp(
      clientHttp: getIt(),
    ),
  );

  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(),
  );

  getIt.registerLazySingleton<AuthLocalStorage>(
    () => AuthLocalStorage(
      localStorageService: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryRemote(
      authClientHttp: getIt(),
      authLocalStorage: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => MyAppViewmodel(
      authRepository: getIt(),
    ),
  );

  getIt.registerFactory(
    () => LoginViewModel(
      repository: getIt(),
    ),
  );

  getIt.registerFactory(
    () => SignupViewmodel(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => LogoutViewmodel(
      authRepository: getIt(),
    ),
  );

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
