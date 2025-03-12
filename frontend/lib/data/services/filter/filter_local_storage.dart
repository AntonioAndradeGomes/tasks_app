import 'dart:convert';
import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/data/services/local_storage_service.dart';
import 'package:frontend/domain/models/filter_model.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

class FilterLocalStorage {
  final LocalStorageService _localStorageService;

  FilterLocalStorage({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  final _log = Logger('FilterLocalStorage');

  AsyncResult<FilterModel> getData() async {
    _log.finer('Get data filter from local storage');
    final result = await _localStorageService.getData(
      Constants.localStorageFilterKey,
    );
    return result.map((data) {
      if (data.isEmpty) {
        return const FilterModel();
      }
      return FilterModel.fromMap(jsonDecode(data));
    });
  }

  AsyncResult<void> saveData(FilterModel filter) async {
    _log.finer('Save data filter to local storage');
    final data = jsonEncode(filter.toMap());
    return _localStorageService.saveData(
      Constants.localStorageFilterKey,
      data,
    );
  }
}
