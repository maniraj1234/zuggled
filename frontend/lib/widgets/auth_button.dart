import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  const AuthButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF2E2B30), // default to dark gray
    this.foregroundColor = Colors.white, // default to white
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: foregroundColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
