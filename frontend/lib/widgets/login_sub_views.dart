import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view_models/login_view_model.dart';
import 'package:frontend/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder:
          (context, viewModel, child) => Column(
            key: const ValueKey('loginwidget'),
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: viewModel.phoneNumberController,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon: CountryCodePicker(
                    hideHeaderText: true,
                    dialogSize: Size(
                      double.infinity,
                      7 / 10 * viewModel.size.height,
                    ),
                    topBarPadding: EdgeInsets.only(left: 24),
                    searchPadding: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    dialogItemPadding: EdgeInsets.all(14),
                    dialogTextStyle: Theme.of(context).textTheme.bodyLarge,
                    initialSelection: viewModel.countryCode.code,
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    searchDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 12),
                      hintText: "Search country code",
                      prefixIcon: Icon(Icons.search),
                    ),
                    headerTextStyle: Theme.of(context).textTheme.headlineSmall!,
                    onChanged: viewModel.onCountryCodeChange,
                  ),
                  border: OutlineInputBorder(),
                  hintText: "Phone Number",
                ),
              ),
              SizedBox(height: viewModel.size.height * 0.05),
              AuthButton(
                onPressed: viewModel.onLoinPress,
                title: 'Send OTP',
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(height: viewModel.size.height * 0.05),
              Center(
                child: Text(
                  "Don't have an account?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 24),
              AuthButton(
                onPressed: viewModel.onSignUpPress,
                title: 'Sign Up',
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
    );
  }
}

class OTPVerificationWidget extends StatelessWidget {
  const OTPVerificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder:
          (context, viewModel, child) => (Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            key: const ValueKey('otpwidget'),
            children: [
              TextField(
                controller: viewModel.otpverifController,
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
                onPressed: viewModel.otpLoginPress,
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
                    onPressed: viewModel.resendOTPHandle,
                    label: const Text('Resend OTP'),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
