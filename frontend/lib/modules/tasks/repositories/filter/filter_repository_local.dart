import 'package:frontend/modules/tasks/repositories/filter/filter_repository.dart';
import 'package:frontend/modules/tasks/services/filter/filter_local_storage.dart';
import 'package:frontend/modules/tasks/models/filter_model.dart';
import 'package:result_dart/result_dart.dart';

class FilterRepositoryLocal implements FilterRepository {
  final FilterLocalStorage _filterLocalStorage;

  FilterRepositoryLocal({
    required FilterLocalStorage filterLocalStorage,
  }) : _filterLocalStorage = filterLocalStorage;

  @override
  AsyncResult<FilterModel> getFileter() {
    return _filterLocalStorage.getData();
  }

  @override
  AsyncResult<void> saveFilter(FilterModel filter) {
    return _filterLocalStorage.saveData(filter);
  }
}
