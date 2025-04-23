import 'package:dio/dio.dart';
import 'package:frontend/core/services/client_http.dart';
import 'package:frontend/core/services/local_storage_service.dart';
import 'package:frontend/modules/auth/auth_module.dart';
import 'package:frontend/modules/auth/services/interceptor/auth_interceptor.dart';
import 'package:frontend/modules/tasks/tasks_module.dart';
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

  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(),
  );

  initAuthModule(getIt);
  initTasksModule(getIt);
}
