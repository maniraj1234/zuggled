import 'package:flutter/material.dart';

class CreatorHomeView extends StatelessWidget {
  const CreatorHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Creator Screen")),
      body: Center(
        child: Material(
          child: Container(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
