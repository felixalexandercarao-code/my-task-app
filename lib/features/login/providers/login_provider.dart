import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

enum AuthStatus { authenticated, unauthenticated, loading }

class LoginState {
  final AuthStatus status;
  final String? token; // The token is nullable

  LoginState({required this.status, this.token});
  
  LoginState copyWith({
    AuthStatus? status,
    String? token,
    bool clearToken = false, // Add a flag to clear the token
  }) {
    return LoginState(
      status: status ?? this.status,
      token: clearToken ? null : (token ?? this.token),
    );
  }
}

@riverpod
class Login extends _$Login {

  @override
  LoginState build() {
    return LoginState(status: AuthStatus.unauthenticated, token: null);
  }

  void login(String email, String password) {
    // TODO API
    state = LoginState(status: AuthStatus.authenticated, token: null);
  }

  void logout() {
    state = state.copyWith(status: AuthStatus.unauthenticated, clearToken: true);
  }
}