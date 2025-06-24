import 'package:flutter/material.dart';
import 'package:frontend/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    IProfileViewModel viewModel = context.watch<IProfileViewModel>();
    return viewModel.user != null
        ? Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            leading: IconButton(
              onPressed: viewModel.goBack,
              icon: const Icon(Icons.arrow_back),
            ),
            scrolledUnderElevation: 4,
            title: Text(viewModel.user!.userName),
          ),

          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              SizedBox(height: 12),
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: FadeInImage.assetNetwork(
                        height: 240,
                        width: 240,
                        fit: BoxFit.fitHeight,
                        placeholder: 'lib/assets/images/placeholder.png',
                        image:
                            "https://drive.google.com/uc?export=download&id=1b00H5pGrdnb2Jszf4DX5rWxGU3Y0ib5i",
                      ),
                    ),
                    SizedBox(
                      height: 240,
                      width: 240,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton.filledTonal(
                          onPressed: () {},
                          icon: Icon(Icons.edit_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28),
              if (viewModel.user!.bio.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Bio",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Edit",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 8),
              Text(
                viewModel.user!.bio,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 24),
              // Divider(),
              Text('Interests (${viewModel.user!.interests.length}/6)'),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ActionChip(
                    avatar: const Icon(Icons.add),
                    label: const Text("Add"),
                    onPressed: viewModel.openAddInterestDialog,
                  ),
                  ...viewModel.user!.interests.map(
                    (interest) => Chip(
                      onDeleted: () {},
                      deleteIcon: Icon(Icons.close_outlined),
                      label: Text(interest),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(fontSize: 18),
                          viewModel.user!.gender.name[0].toUpperCase() +
                              viewModel.user!.gender.name.substring(1),
                        ),
                      ],
                    ),
                  ),

                  // SizedBox(height: 24),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Age",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(fontSize: 18),
                        "${viewModel.user!.age} Years",
                      ),
                    ],
                  ),
                  // Divider(),
                ],
              ),

              SizedBox(height: 24),
              // Divider(),
              Text(
                "Phone Number",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 8),
              Text(
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontSize: 18),
                viewModel.user!.phoneNumber.toString(),
              ),
              SizedBox(height: 24),
              Center(
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ),
                  onPressed: viewModel.logoutHandle,
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: const Text("Logout"),
                ),
              ),
              // Divider(),
            ],
          ),
        )
        : Center(child: CircularProgressIndicator());
  }
}
