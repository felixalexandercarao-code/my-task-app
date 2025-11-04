import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_task_app/features/login/providers/login_provider.dart';
import 'package:my_task_app/shared/models/app_error.dart'; // Your GoRouter provider

/// Injects the auth token into the headers
class AuthInterceptor extends Interceptor {
  final Ref _ref;
  AuthInterceptor(this._ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _ref.read(loginProvider).token; // Read token from your auth provider
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

/// Converts DioExceptions into our custom ApiExceptions
class ErrorInterceptor extends Interceptor {
  final Ref _ref;
  ErrorInterceptor(this._ref);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    ApiException exception = NetworkException(
      message: err.message ?? 'Unknown network error',
    );

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        exception = NetworkException(message: 'Connection timeout');
        break;
      case DioExceptionType.unknown:
         exception = NetworkException(message: 'No internet connection');
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final data = err.response?.data;
        final message = (data is Map ? data['message'] : null) ?? 'An error occurred';

        switch (statusCode) {
          case 401:
            exception = UnauthorizedException(message: message);
            // TODO Log out and redirect to login
            //_ref.read(loginProvider.notifier).logout();
            //_ref.read(goRouterProvider).go(AppRoutes.login);
            break;
          case 404:
            exception = NotFoundException(message: message);
            break;
          case 500:
            exception = ServerException(message: message);
            break;
          default:
            exception = ApiException(message: message, statusCode: statusCode);
        }
        break;
      default:
        break;
    }

    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: exception, // Pass our custom exception
    ));
  }
}

/// A simple logger for debug mode
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    }
    super.onError(err, handler);
  }
}