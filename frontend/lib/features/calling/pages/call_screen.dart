import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

/// A screen that displays the ongoing video call UI.
///
/// This screen is shown after a call has been successfully created or joined.
/// It uses [StreamCallContainer] from the Stream Video Flutter SDK to render
/// the video call interface and handle user interaction.
///
/// Requires a [Call] object, which encapsulates the call state and operations.
class CallStreamScreen extends StatefulWidget {
  /// The [Call] object representing the ongoing video call session.
  ///
  /// This is provided from the call creation flow and is required
  /// to manage call state, participants, and media streams.
  final Call call;

  /// Constructs a [CallStreamScreen] with the given [call].
  const CallStreamScreen({super.key, required this.call});

  @override
  State<CallStreamScreen> createState() => _CallStreamScreenState();
}

class _CallStreamScreenState extends State<CallStreamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Embeds the Stream video call UI into this screen.
      // Automatically manages rendering of participants, controls, etc.
      body: StreamCallContainer(call: widget.call),
    );
  }
}
