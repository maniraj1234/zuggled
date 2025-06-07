import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  void onDestinationChange(value) {
    setState(() {
      selectedIndex = value;
      switch (value) {
        case 0:
          context.go('/home');
        case 1:
          context.go('/history');
        case 2:
          context.go('/coins');
        case 3:
          context.go('/settings');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationChange,
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
