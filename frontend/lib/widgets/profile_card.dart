import 'package:flutter/material.dart';
import 'package:frontend/models/creator.dart';

/// A UI Card to display information of single Creator.
/// To be used in HomeScreen
class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key, required this.creator});
  final Creator creator;
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late Creator creator;
  @override
  void initState() {
    super.initState();
    creator = widget.creator;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(creator.profilePicture.url, fit: BoxFit.fitWidth),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creator.userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Wrap(
                  direction: Axis.horizontal,
                  children:
                      creator.interests.map((item) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Chip(
                            backgroundColor:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                            label: Text(
                              item,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: IconButton.filledTonal(
                        isSelected: creator.isLiked,
                        onPressed: () {
                          /// TODO: Implement like button press handle
                          // setState(() {
                          // creator.isFavorite = !creator.isFavorite;
                          // });
                        },
                        icon: Icon(Icons.favorite_outline, size: 24),
                        selectedIcon: Icon(Icons.favorite, size: 24),
                      ),
                    ),

                    SizedBox(
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.call_outlined, size: 24, weight: 800),
                        label: Text(
                          "10/min",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 56,
                      child: FilledButton.icon(
                        style: ButtonStyle(
                          iconColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onPrimary,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onPrimary,
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.videocam_outlined,
                          size: 28,
                          weight: 800,
                        ),
                        label: Text(
                          "10/min",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
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
