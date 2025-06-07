import 'package:flutter/material.dart';

/// A base class for ProfileCards shown in homescreen's feed.
class UserProfile {
  UserProfile({
    required this.username,
    required this.userid,
    required this.interests,
    required this.isFavorite,
    required this.profilePicture,
  });
  final String username;
  final String userid;
  final List<String> interests;
  bool isFavorite;
  final String profilePicture;
}

/// A UI Card to display information of single User.
/// To be used in HomeScreen
class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key, required this.profile});
  final UserProfile profile;
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late UserProfile profile;
  @override
  void initState() {
    super.initState();
    profile = widget.profile;
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
          Image.asset(profile.profilePicture, fit: BoxFit.fitWidth),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.username,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Wrap(
                  direction: Axis.horizontal,
                  children:
                      profile.interests.map((item) {
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
                        isSelected: profile.isFavorite,
                        onPressed: () {
                          setState(() {
                            profile.isFavorite = !profile.isFavorite;
                          });
                        },
                        icon: Icon(Icons.favorite_outline, size: 24),
                        selectedIcon: Icon(Icons.favorite, size: 24),
                      ),
                    ),

                    SizedBox(
                      height: 56,
                      child: FilledButton.icon(
                        style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onTertiaryContainer,
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                        ),
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
                          foregroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.video_call_outlined,
                          size: 28,
                          weight: 800,
                        ),
                        label: Text(
                          "10/min",
                          style: Theme.of(context).textTheme.titleMedium,
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
