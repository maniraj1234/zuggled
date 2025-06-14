// ignore_for_file: use_build_context_synchronou sly

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/auth_service/auth_service.dart';
import 'package:frontend/services/navigation/navigation_service.dart';
import 'package:frontend/widgets/login_sub_views.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._navService);

  /// NavigationService instance for accessing navigation
  final NavigationService _navService;

  late Size size;

  /// Controller for Phone Number TextField
  final TextEditingController phoneNumberController = TextEditingController();

  /// Controller for OTP TextField
  final TextEditingController otpverifController = TextEditingController();

  int animateWidgetIndex = 0;

  /// Login Widget, shown first, asks for phone number
  late Widget loginWidget = LoginWidget(
    onSignUpPress: () => onSignUpPress(),
    controller: phoneNumberController,
    onLoginPressed: () {
      if (phoneNumberController.text != "") {
        sendOTPLoginHandle();
      }
      animateWidgetIndex = 1;
      notifyListeners();
    },
  );

  /// Widget for OTP verification, to verify OTP or resend it
  /// If OTP is verified, Signin user and go to HomeScreen
  late Widget otpVerifWidget = BackButtonListener(
    onBackButtonPressed: () async {
      animateWidgetIndex = 0;
      notifyListeners();
      return true;
    },
    child: OTPVerificationWidget(
      onResendPress: () => resendOTPHandle(),
      controller: otpverifController,
      onLoginPress: () => otpLoginPress(),
    ),
  );

  /// AuthService Service Instance for Authorization
  final AuthService authService = AuthService();

  /// SnackBar Template
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Send OTP handle for Login Button on Login Widget
  void sendOTPLoginHandle() {
    /// TODO: Enable OTP for all mobile number
    /// Tesing Mobile number: +10123456789

    /// Testing OTP : 111111
    authService.sendOtp(phoneNumberController.text);
  }

  /// This is check if OTP entered is correct
  /// If Incorrect, it will show a Snackbar with error message
  /// If correct, it will show Snackbar with login successful message,
  /// save login credentials using SharedPreferences and
  /// Navigate to HomeScreen;
  void loginHandle() async {
    try {
      await authService.verifyOtp(otpverifController.text);
      // _showSnackBar(context, "Login successful");
      _navService.go(RouteNames.consumerHome);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        otpverifController.clear();
        // _showSnackBar(context, "Invalid Verification Code");
      }
    }
  }

  /// If User already have an account, go to sign up page
  void onSignUpPress() {
    _navService.go(RouteNames.signup);
  }

  /// OTP widget Login button onPress handle
  void otpLoginPress() async {
    if (otpverifController.text.length != 6) {
      // _showSnackBar(context, "Enter a 6 Digit OTP");
      return;
    }
    loginHandle();
  }

  /// Resend OTP button handle
  void resendOTPHandle() async {
    try {
      await authService.sendOtp(phoneNumberController.text);
    } catch (e) {
      // _showSnackBar(context, e.toString());
    }
  }
}
