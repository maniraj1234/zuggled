import 'package:flutter/material.dart';

class CallHistorySearchBar extends StatelessWidget {
  final TextEditingController controller;
  const CallHistorySearchBar({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: 'Search your recent calls',
          hintStyle: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurfaceVariant,
          ),
          prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
