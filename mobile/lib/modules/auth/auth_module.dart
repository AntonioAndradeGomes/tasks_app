import 'package:frontend/modules/auth/repositories/auth_repository.dart';
import 'package:frontend/modules/auth/repositories/auth_repository_remote.dart';
import 'package:frontend/modules/auth/services/auth_client_http.dart';
import 'package:frontend/modules/auth/services/auth_local_storage.dart';
import 'package:frontend/modules/auth/viewmodels/login_view_model.dart';
import 'package:frontend/modules/auth/viewmodels/logout_viewmodel.dart';
import 'package:frontend/modules/auth/viewmodels/my_app_viewmodel.dart';
import 'package:frontend/modules/auth/viewmodels/signup_viewmodel.dart';
import 'package:get_it/get_it.dart';

void initAuthModule(GetIt getIt) {
  getIt.registerLazySingleton<AuthClientHttp>(
    () => AuthClientHttp(
      clientHttp: getIt(),
    ),
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
}
