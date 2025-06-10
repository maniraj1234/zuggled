import 'package:flutter/material.dart';
import 'package:frontend/features/auth_test/data/auth_service.dart';
import 'package:go_router/go_router.dart';

// TODO:Implement SettingsScreen
/// SettingsScreen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(scrolledUnderElevation: 1, title: const Text("Settings")),
        SliverToBoxAdapter(
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text("Logout"),
                  onTap: () async {
                    var auth = AuthService.instance;
                    auth.signOut();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: const Text("Signed Out")));
                    context.go('/login');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
