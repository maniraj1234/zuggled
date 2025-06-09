import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const AuthButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF2E2B30), // default to dark gray
    this.textColor = Colors.white, // default to white
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 0,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
