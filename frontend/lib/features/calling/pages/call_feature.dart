import 'package:flutter/material.dart';
import 'package:frontend/features/calling/pages/call_screen.dart';
import 'package:stream_video/stream_video.dart';

/// A screen that allows the user to initiate or join a video call.

class CallScreen extends StatefulWidget {
  /// The title to display in the app bar.
  final String title;

  /// Constructs a [CallScreen].
  ///
  /// The [title] is shown in the app bar at the top of the screen.
  const CallScreen({super.key, required this.title});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  void createCall() async {
    try {
      // Create or reference a call session by ID.
      // `StreamVideo.instance.makeCall` returns a call controller
      // which you can use to join or set up the call.
      var call = StreamVideo.instance.makeCall(
        callType: StreamCallType(),
        id: 'AqfgQAV2ChJh',
      );

      // Ensure the call exists server‑side (creates it if needed),
      // and fetch its metadata.
      await call.getOrCreate();

      // Navigate to the live call UI, passing the call controller.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CallStreamScreen(call: call)),
      );
    } catch (e) {
      // Log any errors during call creation/joining.
      debugPrint('Error joining or creating call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// The app bar displays the [CallScreen.title] and uses
      /// the inversePrimary color from the current theme.
      ///
      ///
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      /// The body contains a single centered button to start the call.
      body: Center(
        child: ElevatedButton(
          child: const Text('Create Call'),
          onPressed: createCall,
        ),
      ),
    );
  }
}
