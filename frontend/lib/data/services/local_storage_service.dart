import 'package:frontend/data/exceptions/local_storage_exception.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final _log = Logger('LocalStorageService');

  AsyncResult<String> saveData(String key, String value) async {
    try {
      _log.finer('Save data');
      final shared = await SharedPreferences.getInstance();
      await shared.setString(key, value);
      return Success(value);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }

  AsyncResult<String> getData(String key) async {
    try {
      _log.finer('Get data');
      final shared = await SharedPreferences.getInstance();
      final data = shared.getString(key);
      return Success(data ?? "");
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }

  AsyncResult<Unit> removeData(String key) async {
    try {
      _log.finer('Remove data');
      final shared = await SharedPreferences.getInstance();
      await shared.remove(key);
      return const Success(unit);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }
}
