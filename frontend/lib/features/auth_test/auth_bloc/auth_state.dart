class AuthState {
  AuthState clone() {
    return AuthState();
  }
}
final class AuthInitial extends AuthState {}



class AuthLoading extends AuthState {}

class OtpSent extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}