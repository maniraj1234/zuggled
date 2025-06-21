import 'package:flutter/material.dart';

class SearchHistoryList extends StatelessWidget {
  final List<String> history;

  const SearchHistoryList({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      itemCount: history.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
              const SizedBox(width: 16),
              Text(
                history[index],
                style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
              ),
            ],
          ),
        );
      },
    );
  }
}
