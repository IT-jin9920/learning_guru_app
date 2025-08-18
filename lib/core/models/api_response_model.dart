import 'package:dio/dio.dart';

/// Generic API response model
///
/// Provides a standardized way to handle API responses with
/// type safety and error handling.
class ApiResponseModel<T> {
  final T? data;
  final String? message;
  final int statusCode;
  final bool isSuccess;
  final Exception? exception;
  final Headers? headers;

  const ApiResponseModel._({
    this.data,
    this.message,
    required this.statusCode,
    required this.isSuccess,
    this.exception,
    this.headers,
  });

  /// Create successful response
  factory ApiResponseModel.success({
    T? data,
    String? message,
    required int statusCode,
    Headers? headers,
  }) {
    return ApiResponseModel._(
      data: data,
      message: message,
      statusCode: statusCode,
      isSuccess: true,
      headers: headers,
    );
  }

  /// Create error response
  factory ApiResponseModel.error({
    String? message,
    required int statusCode,
    Exception? exception,
    Headers? headers,
  }) {
    return ApiResponseModel._(
      message: message,
      statusCode: statusCode,
      isSuccess: false,
      exception: exception,
      headers: headers,
    );
  }

  /// Create response from Dio response
  factory ApiResponseModel.fromResponse(
      Response response,
      ) {
    final isSuccess = response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;

    return ApiResponseModel._(
      data: response.data,
      statusCode: response.statusCode ?? 500,
      isSuccess: isSuccess,
      headers: response.headers,
    );
  }

  /// Create response from exception
  factory ApiResponseModel.fromException(
      Exception exception, {
        int statusCode = 500,
        String? message,
      }) {
    return ApiResponseModel._(
      message: message ?? exception.toString(),
      statusCode: statusCode,
      isSuccess: false,
      exception: exception,
    );
  }

  @override
  String toString() {
    return 'ApiResponseModel(isSuccess: $isSuccess, statusCode: $statusCode, message: $message)';
  }
}