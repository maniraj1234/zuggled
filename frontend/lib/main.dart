import 'package:flutter/material.dart';
import 'package:frontend/features/calling/pages/call_feature.dart';
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
