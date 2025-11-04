import 'package:dio/dio.dart';
import 'package:my_task_app/shared/models/app_error.dart';
import 'package:my_task_app/shared/services/i_api_service.dart';

class ApiService implements IApiService {
  final Dio _dio;
  ApiService(this._dio);

  /// Helper wrapper to catch and re-throw our custom [ApiException]
  Future<dynamic> _requestWrapper(Future<Response> Function() dioCall) async {
    try {
      final response = await dioCall();
      return response.data;
    } on DioException catch (e) {
      // The ErrorInterceptor has already converted this to an ApiException.
      if (e.error is ApiException) {
        throw e.error!;
      }
      // Fallback for any other unexpected Dio error
      throw NetworkException(message: e.message ?? 'Unknown Dio error');
    } catch (e) {
      // Fallback for non-Dio errors
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _requestWrapper(() => _dio.get(
          path,
          queryParameters: queryParameters,
        ));
  }

  @override
  Future<dynamic> post(String path, {data, Map<String, dynamic>? queryParameters}) {
    return _requestWrapper(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
        ));
  }

  @override
  Future<dynamic> put(String path, {data, Map<String, dynamic>? queryParameters}) {
    return _requestWrapper(() => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
        ));
  }

  @override
  Future<dynamic> delete(String path, {data, Map<String, dynamic>? queryParameters}) {
    return _requestWrapper(() => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
        ));
  }
}