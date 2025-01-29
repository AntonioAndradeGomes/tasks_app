import 'dart:convert';
import 'package:frontend/domain/models/filter_model.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _tokenKey = 'TOKEN';
  static const _filterKey = 'FILTER';
  final _log = Logger('SharedPreferencesService');

  Future<Result<String?>> fetchToken() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      _log.finer('Get token from SharedPreferences');
      return Result.ok(sharedPreferences.getString(_tokenKey));
    } on Exception catch (e) {
      _log.warning('Failed to get token', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> saveToken(String? token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (token == null) {
        _log.finer('Removed token');
        await sharedPreferences.remove(_tokenKey);
      } else {
        _log.finer('Replaced token');
        await sharedPreferences.setString(_tokenKey, token);
      }
      return const Result.ok(null);
    } on Exception catch (e) {
      _log.warning('Failed to set token', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> saveFilter(FilterModel filter) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      _log.finer('Save filter');
      await sharedPreferences.setString(
          _filterKey, jsonEncode(filter.toJson()));
      return const Result.ok(null);
    } on Exception catch (e) {
      _log.warning('Failed to set filter', e);
      return Result.error(e);
    }
  }

  Future<Result<FilterModel>> fetchFilter() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      _log.finer('Get filter from SharedPreferences');
      final json = sharedPreferences.getString(_filterKey);
      if (json == null) {
        _log.finer('No filter found');
        return Result.ok(FilterModel.empty());
      } else {
        _log.finer('Found filter');
        return Result.ok(FilterModel.fromJson(jsonDecode(json)));
      }
    } on Exception catch (e) {
      _log.warning('Failed to get filter', e);
      return Result.error(e);
    }
  }
}
