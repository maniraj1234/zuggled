import 'package:flutter/material.dart';
import 'package:frontend/widgets/auth_button.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
    required this.controller,
    required this.onLoginPressed,
    required this.onSignUpPress,
  });
  final TextEditingController controller;
  final VoidCallback onLoginPressed;
  final VoidCallback onSignUpPress;
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
          onPressed: widget.onSignUpPress,
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
    required this.onResendPress,
  });
  final TextEditingController controller;
  final VoidCallback onLoginPress;
  final VoidCallback onResendPress;
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
              onPressed: widget.onResendPress,
              label: const Text('Resend OTP'),
            ),
          ),
        ),
      ],
    ));
  }
}
