import 'package:flutter/material.dart';
import 'package:frontend/widgets/auth_button.dart';
import 'package:frontend/widgets/auth_textfield.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'lib/assets/images/core/zuggled-banner-image.png',
                height: 140,
                width: 140,
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Welcome to Zuggled',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
