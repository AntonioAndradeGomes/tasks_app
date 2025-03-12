import 'package:frontend/domain/models/filter_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class FilterRepository {
  AsyncResult<FilterModel> getFileter();
  AsyncResult<void> saveFilter(FilterModel filter);
}
