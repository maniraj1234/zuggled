import 'package:flutter/material.dart';

// The main parent widget for the filter list.
class SearchScreenFilter extends StatelessWidget {
  // The map of filter titles to their selection status (e.g., {"Funny": true}).
  final Map<String, bool> filters;
  // The callback function that will be called when a filter is tapped.
  // This would typically trigger a method in your ViewModel.
  final Function(String key) onFilterTapped;

  const SearchScreenFilter({
    super.key,
    required this.filters,
    required this.onFilterTapped,
  });

  @override
  Widget build(BuildContext context) {
    // A list of the filter titles (e.g., ["Funny", "Friendship", ...]).
    final filterKeys = filters.keys.toList();

    // Use a SizedBox to give the horizontal list a specific height.
    return SizedBox(
      height: 36.0, // You can adjust this height as needed.
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filterKeys.length,
        itemBuilder: (context, index) {
          final key = filterKeys[index];
          final isSelected = filters[key] ?? false;

          // Add some spacing between the filter items.
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 2 : 8.0,
              right: index == filterKeys.length - 1 ? 2 : 0,
            ),
            // Use GestureDetector to make the FilterItem tappable.
            child: GestureDetector(
              onTap: () => onFilterTapped(key),
              child: FilterItem(title: key, isSelected: isSelected),
            ),
          );
        },
      ),
    );
  }
}

// The individual filter chip widget.
class FilterItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  const FilterItem({super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        // Use a light purple color when selected, white otherwise.
        color: isSelected ? const Color(0xFFEAE2FF) : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        // Display a border only when not selected.
        border:
            isSelected
                ? null
                : Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Row(
        children: [
          // Show the check icon only when the item is selected.
          if (isSelected)
            const Icon(Icons.check, size: 16.0, color: Color(0xFF333333)),
          // Add spacing between the icon and the text.
          if (isSelected) const SizedBox(width: 4.0),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              // Use a darker text color for better readability.
              color:
                  isSelected ? const Color(0xFF333333) : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
