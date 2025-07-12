import 'package:flutter/material.dart';
import 'package:frontend/view_models/creator_home_vm.dart';
import 'package:provider/provider.dart';

class CreatorHomeView extends StatelessWidget {
  const CreatorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreatorHomeViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Creator Home")),
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("creator home screen"),
              ElevatedButton(
                onPressed: () {
                  viewModel.signout();
                },
                child: Text("signout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
