//
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart' hide FormData, Response;
// import 'package:learning_guru_app/core/constants/app_constants.dart';
// import 'package:learning_guru_app/core/models/api_response_model.dart';
// import 'package:learning_guru_app/utils/logger.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// /// Singleton service for handling all network operations
// ///
// /// This service provides a centralized way to make HTTP requests
// /// with built-in error handling, logging, and loading states.
//
// class NetworkService {
//   static NetworkService? _instance;
//   late final Dio _dio;
//
//   NetworkService._internal() {
//     _dio = Dio();
//   }
//
//   /// Singleton instance getter
//   static NetworkService get instance {
//     _instance ??= NetworkService._internal();
//     return _instance!;
//   }
//
//   /// Initialize the network service with interceptors and configurations
//   Future<void> initialize() async {
//     await _setupInterceptors();
//     _configureBaseOptions();
//   }
//
//   /// Configure base options for Dio
//   void _configureBaseOptions() {
//     _dio.options = BaseOptions(
//       baseUrl: AppConstants.baseUrl,
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//       sendTimeout: const Duration(seconds: 30),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   /// Setup interceptors for logging and error handling
//   Future<void> _setupInterceptors() async {
//     // Add pretty logger only in debug mode
//     if (AppConstants.isDebugMode) {
//       _dio.interceptors.add(
//         PrettyDioLogger(
//           request: true,
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: true,
//           responseBody: true,
//           error: true,
//           compact: true,
//           maxWidth: 120,
//         ),
//       );
//     }
//
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: _onRequest,
//         onResponse: _onResponse,
//         onError: _onError,
//       ),
//     );
//   }
//
//   /// Handle request modifications
//   void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // Add authentication token if available
//     final token = _getAuthToken();
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//
//     AppLogger.debug('Request: ${options.method} ${options.path}');
//     handler.next(options);
//   }
//
//   /// Handle successful responses
//   void _onResponse(Response response, ResponseInterceptorHandler handler) {
//     final statusCode = response.statusCode;
//
//     AppLogger.debug('Response: $statusCode ${response.requestOptions.path}');
//
//     if (_isUnauthorized(statusCode)) {
//       _handleUnauthorized();
//       return;
//     }
//
//     if (_isSuccessful(statusCode)) {
//       handler.next(response);
//       return;
//     }
//
//     _handleErrorResponse(response);
//   }
//
//   /// Handle network errors
//   void _onError(DioException error, ErrorInterceptorHandler handler) {
//     AppLogger.error('Network Error: ${error.message}');
//
//     final statusCode = error.response?.statusCode;
//
//     if (_isUnauthorized(statusCode)) {
//       _handleUnauthorized();
//       return;
//     }
//
//     _handleDioError(error);
//     handler.next(error);
//   }
//
//   /// Check if status code indicates unauthorized access
//   bool _isUnauthorized(int? statusCode) {
//     return statusCode == 401 || statusCode == 403;
//   }
//
//   /// Check if status code indicates success
//   bool _isSuccessful(int? statusCode) {
//     return statusCode != null && statusCode >= 200 && statusCode < 300;
//   }
//
//   /// Handle unauthorized access
//   void _handleUnauthorized() {
//     _showSessionExpiredDialog();
//   }
//
//   /// Handle error responses
//   void _handleErrorResponse(Response response) {
//     final errorMsg =
//         _extractErrorMessage(response.data) ?? 'Unexpected error occurred';
//     _showErrorSnackbar(errorMsg);
//   }
//
//   /// Handle Dio specific errors
//   void _handleDioError(DioException error) {
//     String message = 'Something went wrong';
//
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         message = 'Connection timeout. Please try again.';
//         break;
//       case DioExceptionType.connectionError:
//         message = 'No internet connection. Please check your network.';
//         break;
//       case DioExceptionType.badResponse:
//         message =
//             _extractErrorMessage(error.response?.data) ??
//                 'Server error occurred';
//         break;
//       case DioExceptionType.cancel:
//         message = 'Request was cancelled';
//         break;
//       default:
//         if (error.error is SocketException) {
//           message = 'Network connection failed';
//         }
//         break;
//     }
//
//     _showErrorSnackbar(message);
//   }
//
//   /// Extract error message from response data
//   String? _extractErrorMessage(dynamic data) {
//     if (data is Map<String, dynamic>) {
//       return data['error']?.toString() ??
//           data['message']?.toString() ??
//           data['detail']?.toString();
//     }
//     return null;
//   }
//
//   /// Show error snackbar
//   void _showErrorSnackbar(String message) {
//     Get.snackbar(
//       'Error',
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red.shade100,
//       colorText: Colors.red.shade800,
//       duration: const Duration(seconds: 3),
//       margin: const EdgeInsets.all(16),
//       borderRadius: 8,
//     );
//   }
//
//   /// Show session expired dialog
//   void _showSessionExpiredDialog() {
//     Get.defaultDialog(
//       title: 'Session Expired',
//       middleText: 'Your session has expired. Please login again.',
//       backgroundColor: Colors.white,
//       titleStyle: const TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 18,
//         color: Colors.black,
//       ),
//       middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
//       radius: 12,
//       barrierDismissible: false,
//       actions: [
//         TextButton(
//           onPressed: () => Get.back(),
//           child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
//         ),
//         ElevatedButton(onPressed: _handleRelogin, child: const Text('Login')),
//       ],
//     );
//   }
//
//   /// Handle relogin logic
//   void _handleRelogin() {
//     Get.back(); // Close dialog
//     _clearAuthToken();
//     // Navigate to login screen
//     Get.offAllNamed('/login');
//   }
//
//   /// Get authentication token
//   String? _getAuthToken() {
//     // Implement your token retrieval logic here
//     // e.g., from SharedPreferences, Hive, or GetStorage
//     return null;
//   }
//
//   /// Clear authentication token
//   void _clearAuthToken() {
//     // Implement your token clearing logic here
//   }
//
//   /// Show loading indicator
//   void _showLoading(String? message) {
//     EasyLoading.show(status: message ?? 'Loading...');
//   }
//
//   /// Hide loading indicator
//   void _hideLoading() {
//     EasyLoading.dismiss();
//   }
//
//   // ========== PUBLIC API METHODS ==========
//
//   /// Perform GET request
//   Future<ApiResponseModel<T>> get<T>(
//       String endpoint, {
//         Map<String, dynamic>? queryParameters,
//         Map<String, String>? headers,
//         String? loadingMessage,
//         bool showLoading = true,
//       }) async {
//     try {
//       if (showLoading) _showLoading(loadingMessage);
//
//       final response = await _dio.get(
//         endpoint,
//         queryParameters: queryParameters,
//         options: Options(headers: headers),
//       );
//
//       return ApiResponseModel.success(
//         data: response.data,
//         statusCode: response.statusCode ?? 200,
//         headers: response.headers,
//       );
//     } on DioException catch (e) {
//       return ApiResponseModel.error(
//         message: e.message ?? 'Request failed',
//         statusCode: e.response?.statusCode ?? 500,
//         exception: e,
//       );
//     } finally {
//       if (showLoading) _hideLoading();
//     }
//   }
//
//   /// Perform POST request
//   Future<ApiResponseModel<T>> post<T>(
//       String endpoint, {
//         dynamic data,
//         Map<String, String>? headers,
//         String? loadingMessage,
//         bool showLoading = true,
//       }) async {
//     try {
//       if (showLoading) _showLoading(loadingMessage);
//
//       final response = await _dio.post(
//         endpoint,
//         data: data,
//         options: Options(headers: headers, validateStatus: (status) => true),
//       );
//
//       return ApiResponseModel.success(
//         data: response.data,
//         statusCode: response.statusCode ?? 200,
//         headers: response.headers,
//       );
//     } on DioException catch (e) {
//       return ApiResponseModel.error(
//         message: e.message ?? 'Request failed',
//         statusCode: e.response?.statusCode ?? 500,
//         exception: e,
//       );
//     } finally {
//       if (showLoading) _hideLoading();
//     }
//   }
//
//   /// Perform POST request with multipart data
//   Future<ApiResponseModel<T>> postMultipart<T>(
//       String endpoint, {
//         required FormData formData,
//         Map<String, String>? headers,
//         String? loadingMessage,
//         bool showLoading = true,
//         ProgressCallback? onSendProgress,
//       }) async {
//     try {
//       if (showLoading) _showLoading(loadingMessage ?? 'Uploading...');
//
//       final response = await _dio.post(
//         endpoint,
//         data: formData,
//         options: Options(headers: headers),
//         onSendProgress: onSendProgress,
//       );
//
//       return ApiResponseModel.success(
//         data: response.data,
//         statusCode: response.statusCode ?? 200,
//         headers: response.headers,
//       );
//     } on DioException catch (e) {
//       return ApiResponseModel.error(
//         message: e.message ?? 'Upload failed',
//         statusCode: e.response?.statusCode ?? 500,
//         exception: e,
//       );
//     } finally {
//       if (showLoading) _hideLoading();
//     }
//   }
//
//   /// Perform PUT request
//   Future<ApiResponseModel<T>> put<T>(
//       String endpoint, {
//         dynamic data,
//         Map<String, String>? headers,
//         String? loadingMessage,
//         bool showLoading = true,
//       }) async {
//     try {
//       if (showLoading) _showLoading(loadingMessage);
//
//       final response = await _dio.put(
//         endpoint,
//         data: data,
//         options: Options(headers: headers),
//       );
//
//       return ApiResponseModel.success(
//         data: response.data,
//         statusCode: response.statusCode ?? 200,
//         headers: response.headers,
//       );
//     } on DioException catch (e) {
//       return ApiResponseModel.error(
//         message: e.message ?? 'Update failed',
//         statusCode: e.response?.statusCode ?? 500,
//         exception: e,
//       );
//     } finally {
//       if (showLoading) _hideLoading();
//     }
//   }
//
//   /// Perform DELETE request
//   Future<ApiResponseModel<T>> delete<T>(
//       String endpoint, {
//         Map<String, String>? headers,
//         String? loadingMessage,
//         bool showLoading = true,
//       }) async {
//     try {
//       if (showLoading) _showLoading(loadingMessage ?? 'Deleting...');
//
//       final response = await _dio.delete(
//         endpoint,
//         options: Options(headers: headers),
//       );
//
//       return ApiResponseModel.success(
//         data: response.data,
//         statusCode: response.statusCode ?? 200,
//         headers: response.headers,
//       );
//     } on DioException catch (e) {
//       return ApiResponseModel.error(
//         message: e.message ?? 'Delete failed',
//         statusCode: e.response?.statusCode ?? 500,
//         exception: e,
//       );
//     } finally {
//       if (showLoading) _hideLoading();
//     }
//   }
//
//   /// Cancel all ongoing requests
//   // void cancelAll() {
//   //   _dio.clear();
//   // }
//
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide FormData, Response;
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/constants/app_constants.dart';
import 'package:learning_guru_app/core/models/api_response_model.dart';
import 'package:learning_guru_app/utils/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Singleton service managing all network operations across the app.
/// Features:
/// • Base options and timeout settings
/// • Debug-only request/response logging via PrettyDioLogger
/// • Authorization header injection
/// • Global error handling & user feedback (snackbars, dialogs)
/// • Loading indicator control via flutter_easyloading
/// • Request cancellation via CancelToken

class NetworkService {
  static NetworkService? _instance;
  late final Dio _dio;
  CancelToken _cancelToken = CancelToken();

  NetworkService._internal() {
    _dio = Dio();
  }

  /// Getter for singleton instance
  static NetworkService get instance {
    _instance ??= NetworkService._internal();
    return _instance!;
  }

  /// Initialize Dio: set base options and apply interceptors
  Future<void> initialize() async {
    _configureBaseOptions();
    _setupInterceptors();
  }

  /// Configure base URL, timeouts, and default headers
  void _configureBaseOptions() {
    _dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  /// Add interceptors: logging (in debug) and unified request/response/error handling
  void _setupInterceptors() {
    if (AppConstants.isDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  /// Adds Authorization header if token is available and logs the outgoing request
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _getAuthToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    AppLogger.debug('Request → [${options.method}] ${options.path}');
    handler.next(options);
  }

  /// Handles responses: logs them, checks for unauthorized, success, or error states
  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    AppLogger.debug('Response ← [$status] ${response.requestOptions.path}');

    if (_isUnauthorized(status)) {
      _handleUnauthorized();
      return;
    }
    if (_isSuccessful(status)) {
      handler.next(response);
    } else {
      _handleErrorResponse(response);
    }
  }

  /// Handles various network errors: logs and shows appropriate user messages
  void _onError(DioException error, ErrorInterceptorHandler handler) {
    AppLogger.error('Network Error → ${error.message}');
    final status = error.response?.statusCode;

    if (_isUnauthorized(status)) {
      _handleUnauthorized();
      return;
    }
    _handleDioError(error);
    handler.next(error);
  }

  bool _isUnauthorized(int? statusCode) => statusCode == 401 || statusCode == 403;

  bool _isSuccessful(int? statusCode) => statusCode != null && statusCode >= 200 && statusCode < 300;

  /// Show session expired dialog and force user to login again
  void _handleUnauthorized() {
    Get.defaultDialog(
      title: 'Session Expired',
      middleText: 'Your session expired. Please log in again.',
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _handleReLogin,
          child: const Text('Login'),
        ),
      ],
    );
  }

  void _handleReLogin() {
    Get.back();
    _clearAuthToken();
    Get.offAllNamed('/login'); // Redirect to login page
  }

  /// Display API error message via snackbar
  void _handleErrorResponse(Response response) {
    final msg = _extractErrorMessage(response.data) ?? 'Unexpected error occurred';
    Get.snackbar(
      'Error',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade800,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  /// Show appropriate error message depending on DioExceptionType
  void _handleDioError(DioException error) {
    String msg = 'Something went wrong';
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        msg = 'Connection timeout. Try again later.';
        break;
      case DioExceptionType.connectionError:
        msg = 'No internet. Please check your network.';
        break;
      case DioExceptionType.badResponse:
        msg = _extractErrorMessage(error.response?.data) ?? 'Server error occurred';
        break;
      case DioExceptionType.cancel:
        msg = 'Request was cancelled.';
        break;
      default:
        if (error.error is SocketException) {
          msg = 'Network connection failed.';
        }
    }
    Get.snackbar(
      'Error',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade800,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['error']?.toString() ?? data['message']?.toString() ?? data['detail']?.toString();
    }
    return null;
  }

  /// Show loading indicator overlay
  void _showLoading(String? message) {
    EasyLoading.show(status: message ?? 'Loading...');
  }

  /// Hide loading indicator overlay
  void _hideLoading() {
    EasyLoading.dismiss();
  }

  String? _getAuthToken() {
    // TODO: Return stored auth token from secure/local storage
    return null;
  }

  void _clearAuthToken() {
    // TODO: Clear user auth data in secure/local storage
  }

  /* ==================== PUBLIC API METHODS ==================== */

  Future<ApiResponseModel<T>> get<T>(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
        String? loadingMessage,
        bool showLoading = true,
      }) async {
    if (showLoading) _showLoading(loadingMessage);

    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return ApiResponseModel.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers,
      );
    } on DioException catch (e) {
      return ApiResponseModel.error(
        message: e.message ?? 'Request failed',
        statusCode: e.response?.statusCode ?? 500,
        exception: e,
      );
    } finally {
      if (showLoading) _hideLoading();
    }
  }

  Future<ApiResponseModel<T>> post<T>(
      String endpoint, {
        dynamic data,
        Map<String, String>? headers,
        String? loadingMessage,
        bool showLoading = true,
      }) async {
    if (showLoading) _showLoading(loadingMessage);

    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return ApiResponseModel.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers,
      );
    } on DioException catch (e) {
      return ApiResponseModel.error(
        message: e.message ?? 'Request failed',
        statusCode: e.response?.statusCode ?? 500,
        exception: e,
      );
    } finally {
      if (showLoading) _hideLoading();
    }
  }

  Future<ApiResponseModel<T>> postMultipart<T>(
      String endpoint, {
        required FormData formData,
        Map<String, String>? headers,
        String? loadingMessage,
        bool showLoading = true,
        ProgressCallback? onSendProgress,
      }) async {
    if (showLoading) _showLoading(loadingMessage);

    try {
      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
        cancelToken: _cancelToken,
      );
      return ApiResponseModel.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers,
      );
    } on DioException catch (e) {
      return ApiResponseModel.error(
        message: e.message ?? 'Upload failed',
        statusCode: e.response?.statusCode ?? 500,
        exception: e,
      );
    } finally {
      if (showLoading) _hideLoading();
    }
  }

  Future<ApiResponseModel<T>> put<T>(
      String endpoint, {
        dynamic data,
        Map<String, String>? headers,
        String? loadingMessage,
        bool showLoading = true,
      }) async {
    if (showLoading) _showLoading(loadingMessage);

    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return ApiResponseModel.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers,
      );
    } on DioException catch (e) {
      return ApiResponseModel.error(
        message: e.message ?? 'Update failed',
        statusCode: e.response?.statusCode ?? 500,
        exception: e,
      );
    } finally {
      if (showLoading) _hideLoading();
    }
  }

  Future<ApiResponseModel<T>> delete<T>(
      String endpoint, {
        Map<String, String>? headers,
        String? loadingMessage,
        bool showLoading = true,
      }) async {
    if (showLoading) _showLoading(loadingMessage);

    try {
      final response = await _dio.delete(
        endpoint,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return ApiResponseModel.success(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers,
      );
    } on DioException catch (e) {
      return ApiResponseModel.error(
        message: e.message ?? 'Delete failed',
        statusCode: e.response?.statusCode ?? 500,
        exception: e,
      );
    } finally {
      if (showLoading) _hideLoading();
    }
  }

  /// Cancels all ongoing requests and refreshes the token for later use
  void cancelAll() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Cancelled by user.');
      _cancelToken = CancelToken();
    }
  }
}
