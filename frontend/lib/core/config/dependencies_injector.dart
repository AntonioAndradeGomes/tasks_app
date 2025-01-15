import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/data/repositories/auth/auth_repository_remote.dart';
import 'package:frontend/data/services/api/auth_api_client.dart';
import 'package:frontend/data/services/shared_preferences_service.dart';
import 'package:frontend/ui/auth/login/view_models/login_view_model.dart';
import 'package:frontend/ui/auth/logout/logout_viewmodel.dart';
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

  getIt.registerFactory(
    () => LoginViewModel(
      repository: getIt(),
    ),
  );

  getIt.registerCachedFactory(
    () => LogoutViewmodel(
      authRepository: getIt(),
    ),
  );
}
