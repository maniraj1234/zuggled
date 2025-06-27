// ignore_for_file: constant_identifier_names

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/auth_service/auth_service.dart';
import 'package:frontend/services/navigation/navigation_service.dart';
import 'package:frontend/widgets/login_sub_views.dart';

/// Constants
const int LOGIN_WIDGET = 0;
const int OTP_WIDGET = 1;

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._navService);

  /// NavigationService instance for accessing navigation
  final NavigationService _navService;

  late Size size;

  /// Country Code for CountryCode widget
  CountryCode countryCode = CountryCode.fromCountryCode(
    // For testing purpose, we will use +1 Code
    "US", // for +1
    // uncomment the following for production
    // WidgetsBinding.instance.platformDispatcher.locale.countryCode!,
  );
  void onCountryCodeChange(CountryCode code) {
    countryCode = code;
    notifyListeners();
  }

  /// Controller for Phone Number TextField
  final TextEditingController phoneNumberController = TextEditingController();

  /// Controller for OTP TextField
  final TextEditingController otpverifController = TextEditingController();

  int animateWidgetIndex = LOGIN_WIDGET;

  /// Login Widget, shown first, asks for phone number
  late Widget loginWidget = LoginWidget();
  void onLoinPress() {
    if (phoneNumberController.text != "") {
      /// TODO: Enable OTP for all mobile number
      /// Tesing Mobile number: +10123456789
      /// Testing OTP : 111111
      authService.sendOtp(countryCode.dialCode! + phoneNumberController.text);
    }
    animateWidgetIndex = OTP_WIDGET;
    notifyListeners();
  }

  /// Widget for OTP verification, to verify OTP or resend it
  /// If OTP is verified, Signin user and go to HomeScreen
  late Widget otpVerifWidget = BackButtonListener(
    onBackButtonPressed: () async {
      animateWidgetIndex = LOGIN_WIDGET;
      notifyListeners();
      return true;
    },
    child: OTPVerificationWidget(),
  );

  /// AuthService Service Instance for Authorization
  final AuthService authService = AuthService();

  /// SnackBar Template
  // void _showSnackBar(BuildContext context, String message) {
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(SnackBar(content: Text(message)));
  // }

  /// This is check if OTP entered is correct
  /// If Incorrect, it will show a Snackbar with error message
  /// If correct, it will show Snackbar with login successful message,
  /// save login credentials using SharedPreferences and
  /// Navigate to HomeScreen;
  void loginHandle() async {
    try {
      await authService.verifyOtp(otpverifController.text);
      // _showSnackBar(context, "Login successful");
      // _navService.go(RouteNames.consumerHome);
      _navService.go(RouteNames.networkTest);
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
