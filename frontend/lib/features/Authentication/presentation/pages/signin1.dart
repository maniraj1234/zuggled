import 'package:flutter/material.dart';
import 'package:frontend/features/Authentication/presentation/pages/signin2.dart';
import 'package:frontend/features/Authentication/presentation/widgets/auth_button.dart';
import 'package:frontend/features/Authentication/presentation/widgets/auth_textfield.dart';

class SignIn1 extends StatefulWidget {
  const SignIn1({super.key});

  @override
  State<SignIn1> createState() => _SignIn1State();
}

class _SignIn1State extends State<SignIn1> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                hintText: 'Phone Number',
              ),
              const SizedBox(height: 40),
              AuthButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (cxt) => SignIn2()));
                },
                title: 'Send OTP',
                backgroundColor: Color.fromARGB(255, 31, 32, 25),
                textColor: Colors.white,
              ),
              const SizedBox(height: 40),
              const Text("Don't have an account?"),
              const SizedBox(height: 20),
              AuthButton(
                onPressed: () {},
                title: 'Sign Up',
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
