import 'dart:async';

class Helpers {
  static Future<void> simulateFailedOperation({
    Duration delay = const Duration(seconds: 2),
    String? errorMessage,
  }) async {
    await Future.delayed(delay);
    
    print("Helpers: Delay complete. Throwing test error...");
    throw Exception(errorMessage ?? 'This is a forced test error!');
  }

  static Future<void> simulateSuccessfulOperation({
    Duration delay = const Duration(seconds: 2),
  }) async {
    await Future.delayed(delay);
    print("Helpers: Operation successful.");
  }
}