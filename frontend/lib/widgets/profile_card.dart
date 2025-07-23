import 'package:flutter/material.dart';
import 'package:frontend/models/creator.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    required this.creator,
    required this.onCreateCall,
  });
  final Creator creator;
  final Future<void> Function({required bool video}) onCreateCall;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.creator.profilePicture.url, fit: BoxFit.fitWidth),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.creator.userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Wrap(
                  children:
                      widget.creator.interests.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            backgroundColor:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                            label: Text(item),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.filledTonal(
                      isSelected: widget.creator.isLiked,
                      onPressed: () {
                        // TODO: Like logic
                      },
                      icon: const Icon(Icons.favorite_outline, size: 24),
                      selectedIcon: const Icon(Icons.favorite, size: 24),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => widget.onCreateCall(video: false),
                      icon: const Icon(Icons.call_outlined, size: 24),
                      label: Text(
                        "10/min",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () => widget.onCreateCall(video: true),
                      icon: const Icon(Icons.videocam_outlined, size: 28),
                      label: Text(
                        "10/min",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
