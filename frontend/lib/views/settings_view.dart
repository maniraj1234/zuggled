import 'package:flutter/material.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/auth_service/auth_service.dart';
import 'package:go_router/go_router.dart';

// TODO:Implement SettingsView
/// SettingsView
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
                    var auth = AuthService();
                    auth.signOut();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: const Text("Signed Out")));
                    context.goNamed(RouteNames.login);
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
