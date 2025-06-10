import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';

/// This Screen is Root Screen which will contain
/// NavigationBar and Other Screens so NavigationBar can be persistant across navigation.

class RootNavScreen extends StatefulWidget {
  const RootNavScreen({super.key, required this.child});
  final Widget child;
  @override
  State<RootNavScreen> createState() => _RootNavScreenState();
}

class _RootNavScreenState extends State<RootNavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: BottomNavBar(), body: widget.child);
  }
}
