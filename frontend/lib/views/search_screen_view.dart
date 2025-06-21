import 'package:flutter/material.dart';
import 'package:frontend/view_models/search_screen_view_model.dart';
import 'package:frontend/widgets/search_filter.dart';
import 'package:provider/provider.dart';

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.read<SearchScreenViewModel>();
    viewModel.size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchScreenViewModel>(
      builder: (context, viewModel, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: viewModel.textFieldWidget,
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SearchScreenFilter(
                    filters: viewModel.filters,
                    onFilterTapped: viewModel.onFilterTapped,
                  ),
                ),
                const SizedBox(height: 10.0),
                Expanded(child: viewModel.searchHistoryWidget),
              ],
            ),
          ),
        );
      },
    );
  }
}
