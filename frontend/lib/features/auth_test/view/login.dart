import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth_test/auth_bloc/auth_bloc.dart';
import 'package:frontend/features/auth_test/auth_bloc/auth_event.dart';
import 'package:frontend/features/auth_test/auth_bloc/auth_state.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpSent) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => _OtpSheet(),
            );
          } else if (state is AuthFailure) {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          } else if (state is Authenticated) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Login successful')));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              final user = context.read<AuthBloc>().authService.currentUser;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Logged in as: ${user?.phoneNumber ?? 'Unknown'}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LoggedOutRequested());
                      },
                      child: const Text('Logout'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.go("/call_screen");
                      },
                      child: Text("go to call screen"),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Enter your phone number'),
                      const SizedBox(height: 10),
                      TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final phone = phoneController.text.trim();
                          if (phone.isNotEmpty) {
                            context.read<AuthBloc>().add(
                              SendOtpRequested(phone),
                            );
                          }
                        },
                        child: const Text('Send OTP'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _OtpSheet extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();

  _OtpSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter OTP', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final otp = otpController.text.trim();
                if (otp.isNotEmpty) {
                  context.read<AuthBloc>().add(VerifyOtpRequested(otp));
                }
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
