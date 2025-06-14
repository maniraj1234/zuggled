import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/view_models/shell_view_model.dart';

/// BottomNavBar, used as Bottom Navigation Bar in application
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: context.watch<ShellViewModel>().selectedIndex,
      onDestinationSelected: context.watch<ShellViewModel>().changeDestination,
      destinations: <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history),
          label: "History",
        ),
        NavigationDestination(
          icon: Icon(Icons.paid_outlined),
          selectedIcon: Icon(Icons.paid),
          label: "Coins",
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
  }
}
