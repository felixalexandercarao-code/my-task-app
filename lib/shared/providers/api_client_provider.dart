import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_task_app/shared/services/api_service.dart';
import 'package:my_task_app/shared/services/i_api_service.dart';
import 'package:my_task_app/shared/services/interceptors.dart';

/// Provider for the base Dio instance
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:5000', // Your API base URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add interceptors
  dio.interceptors.addAll([
    AuthInterceptor(ref), // For handling auth tokens
    ErrorInterceptor(ref), // For handling errors and 401s
    if (kDebugMode) LoggingInterceptor(), // For logging in debug mode
  ]);

  return dio;
});

/// The main provider that the app will use to make API calls.
///
/// This provides the [IApiService] interface, not the concrete implementation.
/// This allows for easy mocking in tests.
final apiServiceProvider = Provider<IApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});