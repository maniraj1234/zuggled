import 'package:flutter/material.dart';
import 'package:frontend/services/backend_test/data/message_service.dart';
import 'package:frontend/services/backend_test/model/message_model.dart';

/// A UI screen that test
///
/// This widget fetches a message from the backend using [MessageService]
/// and displays the result once available.Only for testing purposes.
class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    MessageService service = MessageService();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Network Test')),
        body: FutureBuilder<MessageModel>(
          future: service.getMessage(), // Fetch message from the backend
          // Use the MessageService to fetch the message
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Center(child: Text(snapshot.data!.message));
            } else {
              return Center(child: Text('No data found'));
            }
          },
        ),
      ),
    );
  }
}
