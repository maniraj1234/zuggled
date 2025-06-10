import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/auth_test/data/auth_service.dart';
import 'package:frontend/widgets/auth_button.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late Size size;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpverifController = TextEditingController();
  late Widget _loginWidget;
  late Widget _otpVerifWidget;
  int _animateWidgetIndex = 0;
  late AuthService authService;
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// This is check if OTP entered is correct
  /// If Incorrect, it will show a Snackbar with error message
  /// If correct, it will show Snackbar with login successful message,
  /// save login credentials using SharedPreferences and
  /// Navigate to HomeScreen;
  void loginHandle() async {
    try {
      var res = await authService.verifyOtp(_otpverifController.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_verification_id', res.credential.toString());
      _showSnackBar("Login successful");
      if (mounted) {
        context.go('/home');
      } else {
        _showSnackBar("Something went wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        _otpverifController.clear();
        _showSnackBar("Invalid Verification Code");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    authService = AuthService.instance;
    _loginWidget = LoginWidget(
      controller: _phoneController,
      onLoginPressed: () {
        /// TODO: Enable OTP for all mobile number
        /// Tesing Mobile number: +10123456789
        /// Testing OTP : 111111
        authService.sendOtp('+10123456789');
        setState(() {
          _animateWidgetIndex = 1;
        });
      },
    );
    _otpVerifWidget = BackButtonListener(
      onBackButtonPressed: () async {
        setState(() {
          _animateWidgetIndex = 0;
        });
        return true;
      },
      child: OTPVerificationWidget(
        controller: _otpverifController,
        onLoginPress: () async {
          if (_otpverifController.text.length != 6) {
            _showSnackBar("Enter a 6 Digit OTP");
            return;
          }
          loginHandle();
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: MediaQuery.of(context).padding.top + 0.05 * size.height,
          bottom: 1 / 10 * size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'lib/assets/images/core/zuggled-banner-image.png',
              height: 120,
              width: 120,
            ),
            Center(
              child: Text(
                'Welcome to Zuggled',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: size.height * 0.12),
            AnimatedSwitcher(
              layoutBuilder:
                  (currentChild, previousChildren) => Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      // ClipRect helps prevent overflow during slide
                      child: currentChild,
                    ),
                  ),
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Apply a slide animation for the entering child
                final offsetAnimation = Tween<Offset>(
                  begin: Offset(
                    _animateWidgetIndex == 0 ? -1.0 : 1.0,
                    0.0,
                  ), // Starts from right
                  end: Offset.zero,
                ).animate(animation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    // Add fade for a smoother blend
                    opacity: Tween<double>(begin: 0, end: 1).animate(animation),
                    child: child,
                  ),
                );
              },
              duration: Durations.medium3,
              switchInCurve: Cubic(0.05, 0.7, 0.1, 1),
              switchOutCurve: Cubic(0.3, 0, 0.8, 0.15),
              child: _animateWidgetIndex == 0 ? _loginWidget : _otpVerifWidget,
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
    required this.controller,
    required this.onLoginPressed,
  });
  final TextEditingController controller;
  final VoidCallback onLoginPressed;
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('loginwidget'),
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: widget.controller,
          keyboardType: TextInputType.phone,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Phone Number'),
          ),
        ),
        SizedBox(height: size.height * 0.05),
        AuthButton(
          onPressed: widget.onLoginPressed,
          title: 'Send OTP',
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        SizedBox(height: size.height * 0.05),
        Center(
          child: Text(
            "Don't have an account?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 24),
        AuthButton(
          onPressed: () {},
          title: 'Sign Up',
          backgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
      ],
    );
  }
}

class OTPVerificationWidget extends StatefulWidget {
  const OTPVerificationWidget({
    super.key,
    required this.controller,
    required this.onLoginPress,
  });
  final TextEditingController controller;
  final VoidCallback onLoginPress;
  @override
  State<OTPVerificationWidget> createState() => _OTPVerificationWidgetState();
}

class _OTPVerificationWidgetState extends State<OTPVerificationWidget> {
  @override
  Widget build(BuildContext context) {
    return (Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      key: const ValueKey('otpwidget'),
      children: [
        TextField(
          controller: widget.controller,
          keyboardType: TextInputType.numberWithOptions(),
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Enter the OTP"),
          ),
        ),
        const SizedBox(height: 40),

        /// Login Button
        AuthButton(
          onPressed: widget.onLoginPress,
          title: 'Login',
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(height: 40),
        Center(
          child: Text(
            "Did not receive anything?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 20),

        /// Resend OTP button
        Center(
          child: SizedBox(
            height: 56,
            width: 160,
            child: FilledButton.tonalIcon(
              icon: Icon(Icons.restart_alt),
              onPressed: () {},
              label: const Text('Resend OTP'),
            ),
          ),
        ),
      ],
    ));
  }
}
