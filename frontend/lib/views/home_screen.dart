import 'package:flutter/material.dart';
import 'package:frontend/widgets/profile_card.dart';

//TODO: Implement functionalites in HomeScreen
/// HomeScreen, the home of application. It consists:
/// 1. SearchBar
/// 2. Favorites Screen Button
/// 3. Account Screen Button
/// 4. List of other user's profiles in feed
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          forceMaterialTransparency: true,
          floating: true,
          titleSpacing: 12,
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: FilledButton.tonalIcon(
                    icon: Icon(Icons.search, size: 24),
                    onPressed: () {},
                    label: const Text("Search Zuggled"),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      textStyle: WidgetStatePropertyAll(
                        TextStyle(fontSize: 16),
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.surfaceContainer,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              SizedBox(
                height: 46,
                width: 46,
                child: IconButton.filledTonal(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.surfaceContainer,
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                ),
              ),
              SizedBox(width: 8),
              SizedBox(
                height: 40,
                width: 40,
                child: IconButton.filledTonal(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {},
                  icon: Image.asset("lib/assets/images/user_pfp_test.png"),
                ),
              ),
            ],
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Chip(label: const Text("Funny")),
                      SizedBox(width: 8),
                      Chip(label: const Text("Adventure")),
                      SizedBox(width: 8),
                      Chip(label: const Text("Friendship")),
                      SizedBox(width: 8),
                      Chip(label: const Text("Introvert")),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                ProfileCard(
                  profile: UserProfile(
                    username: "carla_charms",
                    userid: "user_001",
                    interests: [
                      "Music",
                      "Books",
                      "Photography",
                      "Hiking",
                      "Introvert",
                    ],
                    isFavorite: false,
                    profilePicture: "lib/assets/images/user_001.png",
                  ),
                ),
                SizedBox(height: 12),

                ProfileCard(
                  profile: UserProfile(
                    username: "art_lover",
                    userid: "user_002",
                    interests: ["painting", "sculpture", "history"],
                    isFavorite: false,
                    profilePicture: "lib/assets/images/user_002.png",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
