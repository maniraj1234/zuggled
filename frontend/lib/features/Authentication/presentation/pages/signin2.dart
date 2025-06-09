import 'package:flutter/material.dart';
import 'package:frontend/features/Authentication/presentation/widgets/auth_button.dart';
import 'package:frontend/features/Authentication/presentation/widgets/auth_textfield.dart';

class SignIn2 extends StatefulWidget {
  const SignIn2({super.key});

  @override
  State<SignIn2> createState() => _SignIn2State();
}

class _SignIn2State extends State<SignIn2> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/core/zuggled-banner-image.png',
                height: 140,
                width: 140,
              ),
              const SizedBox(height: 10),
              Text(
                'Welcome to Zuggled',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 60),
              AuthTextFormField(
                controller: _phoneController,
                hintText: 'Enter OTP sent to your phone',
              ),
              const SizedBox(height: 40),
              AuthButton(
                onPressed: () {},
                title: 'Login',
                backgroundColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 40),
              const Text("Did not receive the OTP?"),
              const SizedBox(height: 20),
              AuthButton(
                onPressed: () {},
                title: 'Resend OTP',
                backgroundColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
