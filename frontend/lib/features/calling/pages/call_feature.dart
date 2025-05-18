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

class _MyHomePageState extends State<MyHomePage> {
  String callID = "CallID";

  @override
  void initState() {
    super.initState();
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(26, 0, 36, 0),
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
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 48),
            ElevatedButton(
              child: const Text('Create Call'),
              onPressed: () async {
                try {
                  var call = StreamVideo.instance.makeCall(
                    callType: StreamCallType.defaultType(),
                    id: callID,
                  );
                  await call.getOrCreate();
                  // Created ahead
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallScreen(call: call),
                    ),
                  );
                } catch (e) {
                  debugPrint('Error joining or creating call: $e');
                  debugPrint(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
