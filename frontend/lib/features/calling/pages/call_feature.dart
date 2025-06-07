import 'package:flutter/material.dart';
import 'package:frontend/features/calling/pages/call_screen.dart';
import 'package:stream_video/stream_video.dart';

/// A screen that allows the user to initiate or join a video call.
///
/// This screen displays a text field for entering a Call ID and a button to
/// create or join a video call using Stream Video SDK. When the call is
/// successfully created or joined, it navigates to [CallStreamScreen].
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
  /// Holds the user input for the Call ID.
  ///
  /// This ID is used to uniquely identify the video call session.
  String callID = "CallID";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// The app bar displays the screen title and uses the theme’s inversePrimary color.
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      /// The body contains a text field to input the call ID
      /// and a button to create or join the call.
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// A text field for entering the call ID.
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 0, 36, 0),
              child: TextField(
                onChanged:
                    (value) => setState(() {
                      callID = value;
                    }),
                decoration: InputDecoration(
                  hintText: "Call ID",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 48),

            /// A button that initiates the video call using the entered Call ID.
            ///
            /// On success, navigates to [CallStreamScreen] with the created call.
            ElevatedButton(
              child: const Text('Create Call'),
              onPressed: () async {
                try {
                  final call = StreamVideo.instance.makeCall(
                    callType: StreamCallType.defaultType(),
                    id: callID,
                  );
                  await call.getOrCreate();
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallStreamScreen(call: call),
                      ),
                    );
                  }
                } catch (e) {
                  debugPrint('Error joining or creating call: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
