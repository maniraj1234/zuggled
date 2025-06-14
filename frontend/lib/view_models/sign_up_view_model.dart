import 'package:flutter/widgets.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/navigation/navigation_service.dart';

/// ViewModel for Sign up screen
class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel(this._navService);

  /// Navigation Service instance for navigation handling
  final NavigationService _navService;

  /// Controller for Phone Number TextInput
  TextEditingController phoneNumberController = TextEditingController();

  /// TODO:Implement send OTP in SignUp Screen
  /// Handle for Send OTP Button
  void onPressSendOTP() {}

  /// Handle for Go to Login Screen
  void onPressLogin() {
    _navService.go(RouteNames.login);
  }
}
