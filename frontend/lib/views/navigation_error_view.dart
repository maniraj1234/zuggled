import 'package:flutter/material.dart';

///** Go Router Error Screen **
///
/// This screen is displayed when a navigation error occurs in the application.
/// It provides a user-friendly message indicating that the requested page does not exist.
class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error! the page you are looking for does not exist'),
      ),
      body: Center(child: Text(errorMessage)),
    );
  }
}
