import 'package:flutter/material.dart';

import 'package:stream_video_flutter/stream_video_flutter.dart';

import 'package:frontend/features/calling/pages/call_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
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
