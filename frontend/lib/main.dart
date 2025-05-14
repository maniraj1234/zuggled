import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Right after creation client connects to the backend and authenticates the user.
  // You can set `options: StreamVideoOptions(autoConnect: false)` if you want to disable auto-connect.
  final client = StreamVideo(
    'mmhfdzb5evj2',
    user: User.regular(userId: 'Aurra_Sing', role: 'admin', name: 'John Doe'),
    userToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL0F1cnJhX1NpbmciLCJ1c2VyX2lkIjoiQXVycmFfU2luZyIsInZhbGlkaXR5X2luX3NlY29uZHMiOjYwNDgwMCwiaWF0IjoxNzQ3MTg1MzYwLCJleHAiOjE3NDc3OTAxNjB9.fAW31QaG6z_6LkDnEdGQ5Ck7ppVT6fF4A9jMDabB2IE',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Create Call'),
          onPressed: () async {
            try {
              var call = StreamVideo.instance.makeCall(
                callType: StreamCallType(),
                id: 'AqfgQAV2ChJh',
              );

              await call.getOrCreate();

              // Created ahead
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CallScreen(call: call)),
              );
            } catch (e) {
              debugPrint('Error joining or creating call: $e');
              debugPrint(e.toString());
            }
          },
        ),
      ),
    );
  }
}

class CallScreen extends StatefulWidget {
  final Call call;

  const CallScreen({Key? key, required this.call}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StreamCallContainer(call: widget.call));
  }
}
