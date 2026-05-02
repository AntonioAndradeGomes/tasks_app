import 'package:frontend/core/errors/app_exception.dart';

class HttpException extends AppException {
  final int? statusCode;
  final String? status;
  final List<String>? errors;

  HttpException(
    super.message,
    super.stackTrace, {
    this.statusCode,
    this.status,
    this.errors,
  });
}
