import 'package:frontend/core/errors/http_exception.dart';

class HttpUnauthorizedException extends HttpException {
  HttpUnauthorizedException(
    super.message,
    super.stackTrace, {
    super.statusCode = 401,
    super.status = 'Unauthorized',
  });
}
