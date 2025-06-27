import 'package:flutter/material.dart';
import 'package:frontend/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.read<SearchViewModel>();
    viewModel.size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, viewModel, state) {
        return Scaffold(
          body: SafeArea(
            // Adding SingleChildScrollView so there is no Bottom Overflowed Error
            // When User opens keyboard
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: viewModel.textFieldWidget,
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            viewModel.filters.keys
                                .map(
                                  (filter) => Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: FilterChip(
                                      selected: viewModel.filters[filter]!,
                                      label: Text(filter),
                                      onSelected: (value) {
                                        viewModel.onFilterTapped(filter);
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, bottom: 12),
                    child: const Text("Recent Searches"),
                  ),

                  ...viewModel.searchHistory.map(
                    (value) => ListTile(
                      onTap: () {},
                      leading: Icon(Icons.history),
                      title: Text(value),
                    ),
                  ),
                  SizedBox(height: 24),
                  Image.asset(
                    'lib/assets/images/search.png',
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
