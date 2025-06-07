abstract class AuthEvent {}

class InitEvent extends AuthEvent {}

class SendOtpRequested extends AuthEvent {
  final String phoneNumber;
  SendOtpRequested(this.phoneNumber);
}

class VerifyOtpRequested extends AuthEvent {
  final String otp;
  VerifyOtpRequested(this.otp);
}

class LoggedOutRequested extends AuthEvent {}
