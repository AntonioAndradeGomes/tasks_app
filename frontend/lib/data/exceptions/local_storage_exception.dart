import 'package:frontend/core/errors/app_exception.dart';

class LocalStorageException extends AppException {
  LocalStorageException(super.message, [super.stackTrace]);
}
