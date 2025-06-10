import 'package:flutter/material.dart';
import 'package:frontend/widgets/auth_button.dart';
import 'package:frontend/widgets/auth_textfield.dart';

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

  @override
  void initState() {
    super.initState();
    _loginWidget = LoginWidget(
      controller: _phoneController,
      onLoginPressed:
          () => setState(() {
            _animateWidgetIndex = 1;
          }),
    );
    _otpVerifWidget = BackButtonListener(
      onBackButtonPressed: () async {
        setState(() {
          _animateWidgetIndex = 0;
        });
        return true;
      },
      child: OTPVerificationWidget(controller: _otpverifController),
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
        AuthTextFormField(
          controller: widget.controller,
          hintText: 'Phone Number',
          keyboardType: TextInputType.phone,
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
  const OTPVerificationWidget({super.key, required this.controller});
  final TextEditingController controller;
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
        AuthTextFormField(
          controller: widget.controller,
          hintText: 'Enter the OTP',
        ),
        const SizedBox(height: 40),
        AuthButton(
          onPressed: () {},
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
