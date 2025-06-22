import 'package:flutter/material.dart';

class CallHistoryItem extends StatelessWidget {
  final String username;
  final String imagePath;
  final String dateTimeText;

  const CallHistoryItem({
    super.key,
    required this.username,
    required this.imagePath,
    required this.dateTimeText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateTimeText,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.call_outlined),
            onPressed: () {},
            color: colorScheme.onSurface.withOpacity(0.8),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(Icons.videocam_outlined),
            onPressed: () {},
            color: colorScheme.onSurface.withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
