import 'package:flutter/material.dart';
import 'package:frontend/view_models/call_history_view_model.dart';
import 'package:frontend/widgets/call_history_item.dart';
import 'package:provider/provider.dart';

// TODO: Implement HistoryView
/// HistoryView used to show previoud history of calls
class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.read<CallHistoryViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CallHistoryViewModel>(
      builder: (context, viewModel, state) {
        return SafeArea(
          child: Column(
            children: [
              viewModel.callHistorySearchBar,
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.userCallHistory.length,
                  itemBuilder: (context, index) {
                    final entry = viewModel.userCallHistory[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 10.0,
                      ),
                      child: CallHistoryItem(
                        username: entry['name']!,
                        imagePath: entry['image_url']!,
                        dateTimeText: entry['date_time']!,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
