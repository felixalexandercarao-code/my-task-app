class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => 'ApiException(message: $message, statusCode: $statusCode)';
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({String message = 'Unauthorized'})
      : super(message: message, statusCode: 401);
}

class NotFoundException extends ApiException {
  NotFoundException({String message = 'Not Found'})
      : super(message: message, statusCode: 404);
}

class ServerException extends ApiException {
  ServerException({String message = 'Internal Server Error'})
      : super(message: message, statusCode: 500);
}

class NetworkException extends ApiException {
  NetworkException({String message = 'Network Error'})
      : super(message: message);
}