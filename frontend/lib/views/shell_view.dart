import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';

/// This Screen is Root Screen which will contain
/// NavigationBar and Other Screens so NavigationBar can be persistant across navigation.

class ShellView extends StatefulWidget {
  const ShellView({super.key, required this.child});
  final Widget child;
  @override
  State<ShellView> createState() => _ShellViewState();
}

class _ShellViewState extends State<ShellView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: BottomNavBar(), body: widget.child);
  }
}
