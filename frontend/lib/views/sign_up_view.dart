import 'package:flutter/material.dart';
import 'package:frontend/view_models/sign_up_view_model.dart';
import 'package:provider/provider.dart';

/// A Sign up screen for creating new account
class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder:
          (context, viewModel, child) => Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'lib/assets/images/core/zuggled-banner-image.png',
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(height: 12),
                  Center(
                    child: Text(
                      'Create a new account',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(height: size.height * 0.06),
                  Text(
                    "Lets verify your phone number first",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  SizedBox(height: size.height * 0.02),
                  TextField(
                    controller: viewModel.phoneNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Phone number",
                    ),
                  ),
                  SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: viewModel.onPressSendOTP,
                      child: Text(
                        "Sent OTP",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Text("Already have an account ?"),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 56,
                    width: 120,
                    child: FilledButton.tonal(
                      onPressed: () => viewModel.onPressLogin(),
                      child: Text(
                        "Login",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
