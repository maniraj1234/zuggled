import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Controller for Sign up screen
class SignUpController {
  /// Controller for Phone Number TextInput
  TextEditingController phoneNumberController = TextEditingController();

  /// TODO:Implement send OTP in SignUp Screen
  /// Handle for Send OTP Button
  void onPressSendOTP() {}

  /// Handle for Go to Login Screen
  void onPressLogin(BuildContext context) {
    context.go('/login');
  }
}
