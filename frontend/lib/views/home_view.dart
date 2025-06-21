import 'package:flutter/material.dart';
import 'package:frontend/view_models/home_view_model.dart';
import 'package:frontend/widgets/profile_card.dart';
import 'package:provider/provider.dart';

//TODO: Implement functionalites in HomeView
/// HomeView, the home of application. It consists:
/// 1. SearchBar
/// 2. Favorites View Button
/// 3. Account View Button
/// 4. List of other user's profiles in feed
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.read<HomeViewModel>();
    viewModel.size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverAppBar(
              forceMaterialTransparency: true,
              floating: true,
              titleSpacing: 12,
              title: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Material(
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHigh,
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox.square(
                                    dimension: 48,
                                    child: Icon(Icons.search, size: 24),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: viewModel.onSearchTap,
                                      child: Text(
                                        "Search Zuggled",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  SizedBox(
                                    height: 40,
                                    child: FilledButton.tonal(
                                      style: ButtonStyle(
                                        padding: WidgetStatePropertyAll(
                                          EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                        ),
                                        backgroundColor: WidgetStatePropertyAll(
                                          Theme.of(context).colorScheme.surface,
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.paid_outlined, size: 24),
                                          SizedBox(width: 8),
                                          Text(
                                            "235",
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox.square(
                                    dimension: 52,
                                    child: Center(
                                      child: SizedBox.square(
                                        dimension: 36,
                                        child: IconButton.filledTonal(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {},
                                          icon: Image.asset(
                                            "lib/assets/images/user_pfp_test.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) {
                    if (!viewModel.isInitialized) {
                      viewModel.initializeFeed();
                      return (Center(child: CircularProgressIndicator()));
                    }
                    return (Column(
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
                        ...viewModel.feed.map(
                          (value) => ProfileCard(creator: value),
                        ),

                        // ProfileCard(
                        //   profile: UserProfile(
                        //     username: "Carla_Ch4rms",
                        //     userid: "user_001",
                        //     interests: [
                        //       "Music",
                        //       "Books",
                        //       "Photography",
                        //       "Hiking",
                        //       "Introvert",
                        //     ],
                        //     isFavorite: false,
                        //     profilePicture: "lib/assets/images/user_001.png",
                        //   ),
                        // ),
                        // SizedBox(height: 12),
                        // ProfileCard(
                        //   profile: UserProfile(
                        //     username: "art_lover",
                        //     userid: "user_002",
                        //     interests: ["Painting", "Sculpture", "History"],
                        //     isFavorite: false,
                        //     profilePicture: "lib/assets/images/user_002.png",
                        //   ),
                        // ),
                        // ProfileCard(
                        //   profile: UserProfile(
                        //     username: "music.kitten",
                        //     userid: "user_003",
                        //     interests: ["Guitar", "Concerts", "Songwriting"],
                        //     isFavorite: false,
                        //     profilePicture: "lib/assets/images/user_003.png",
                        //   ),
                        // ),
                        // ProfileCard(
                        //   profile: UserProfile(
                        //     username: "itsAlia",
                        //     userid: "user_004",
                        //     interests: ["Gaming", "Books", "Adventure", "Science"],
                        //     isFavorite: false,
                        //     profilePicture: "lib/assets/images/user_004.png",
                        //   ),
                        // ),
                      ],
                    ));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
