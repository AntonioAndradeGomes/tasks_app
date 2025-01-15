import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final int? statusCode;
  final String? message;
  final String? status;
  final List<String>? errors;

  const CustomException({
    this.statusCode,
    this.message,
    this.status,
    this.errors,
  });

  @override
  List<Object?> get props => [statusCode, message, status, errors];
}
