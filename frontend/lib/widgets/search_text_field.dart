import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPopScreen;
  final VoidCallback onClearTextField;
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onClearTextField,
    required this.onPopScreen,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      style: const TextStyle(fontSize: 18, color: Colors.black87),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        prefixIcon: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onPopScreen,
        ),
        // The prefixIcon has been removed from here.
        hintText: 'Search for people',
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        enabledBorder: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.4,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 2.0,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: onClearTextField,
        ),
      ),
    );
  }
}
