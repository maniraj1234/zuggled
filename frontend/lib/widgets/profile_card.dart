import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app_keys.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/models/creator.dart';
import 'package:frontend/call_screen.dart';
import 'package:frontend/tutorial_user.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_video/stream_video.dart';
import 'package:stream_video_push_notification/stream_video_push_notification.dart';
import 'package:uuid/uuid.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("[FCM] 🔧 Background handler triggered");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  try {
    final tutorialUser = TutorialUser.user1();
    // if (tutorialUser == null) {
    //   // print("[FCM] ❌ No user found in local storage.");
    //   return;
    // }

    // print("[FCM] ✅ Found user: ${tutorialUser.user.id}");

    final streamVideo = StreamVideo.create(
      AppKeys.streamApiKey,
      user: tutorialUser.user,
      userToken: tutorialUser.token,
      options: const StreamVideoOptions(
        logPriority: Priority.verbose,
        keepConnectionsAliveWhenInBackground: true,
      ),
      pushNotificationManagerProvider:
          StreamVideoPushNotificationManager.create(
            iosPushProvider: const StreamVideoPushProvider.apn(
              name: AppKeys.iosPushProviderName,
            ),
            androidPushProvider: const StreamVideoPushProvider.firebase(
              name: AppKeys.androidPushProviderName,
            ),
            pushParams: const StreamVideoPushParams(
              appName: 'Ringing Tutorial',
              ios: IOSParams(iconName: 'IconMask'),
            ),
            registerApnDeviceToken: true,
          ),
    )..connect();

    print("[FCM] ✅ StreamVideo client connected.");

    final subscription = streamVideo.observeCallDeclinedCallKitEvent();
    streamVideo.disposeAfterResolvingRinging(
      disposingCallback: () {
        print("[FCM] 🔔 Disposing ringing context.");
        subscription?.cancel();
      },
    );

    await streamVideo.handleRingingFlowNotifications(message.data);
    print("[FCM] ✅ Handled ringing notification.");
  } catch (e, stk) {
    print("[FCM] ❌ Error handling remote message: $e");
    print(stk.toString());
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key, required this.creator});
  final Creator creator;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  static const int _fcmSubscription = 1;
  static const int _callKitSubscription = 2;

  final Subscriptions subscriptions = Subscriptions();
  final List<String> selectedUserIds = [];
  bool videoCall = true;

  @override
  void initState() {
    super.initState();
    print("[HomeScreen] 🔧 initState");

    FirebaseMessaging.instance.requestPermission().then((settings) {
      print("[FCM] 🔐 Permission status: ${settings.authorizationStatus}");
    });

    _tryConsumingIncomingCallFromTerminatedState();
    _observeFcmMessages();
    _observeCallKitEvents();
  }

  void _tryConsumingIncomingCallFromTerminatedState() {
    if (CurrentPlatform.isIos) return;

    // print("[Android] 🔍 Checking for call from terminated state...");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      StreamVideo.instance.consumeAndAcceptActiveCall(
        onCallAccepted: (callToJoin) {
          GoRouter.of(context).pushNamed('call_screen', extra: callToJoin);
        },
      );
    });
  }

  Future<bool> _handleRemoteMessage(RemoteMessage message) async {
    print("[FCM] 📩 Received foreground message: ${message.data}");
    return StreamVideo.instance.handleRingingFlowNotifications(message.data);
  }

  _observeFcmMessages() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // print("[FCM] 🔁 Observing background and foreground messages");

    subscriptions.add(
      _fcmSubscription,
      FirebaseMessaging.onMessage.listen(_handleRemoteMessage),
    );
  }

  void _observeCallKitEvents() {
    final streamVideo = StreamVideo.instance;
    // print("[CallKit] 🎧 Subscribing to call events");

    subscriptions.add(
      _callKitSubscription,
      streamVideo.observeCoreCallKitEvents(
        onCallAccepted: (callToJoin) {
          GoRouter.of(context).pushNamed('call_screen', extra: callToJoin);
        },
      ),
    );
  }

  Future<void> _createRingingCall() async {
    print('sameer is calling');
    print("[Call] 📞 Creating ringing call...");

    final call = StreamVideo.instance.makeCall(
      callType: StreamCallType.defaultType(),
      id: Uuid().v4(),
    );

    final result = await call.getOrCreate(
      memberIds: [TutorialUser.user2().user.id],
      video: false,
      ringing: true,
    );

    print('$result result');

    result.fold(
      success: (success) async {
        if (mounted) {
          GoRouter.of(context).pushNamed('call_screen', extra: call);
        }
      },
      failure: (failure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.error.message)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(widget.creator.profilePicture.url, fit: BoxFit.fitWidth),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.creator.userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Wrap(
                  direction: Axis.horizontal,
                  children:
                      widget.creator.interests.map((item) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Chip(
                            backgroundColor:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                            label: Text(
                              item,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: IconButton.filledTonal(
                        isSelected: widget.creator.isLiked,
                        onPressed: () {
                          /// TODO: Implement like button press handle
                          // setState(() {
                          // creator.isFavorite = !creator.isFavorite;
                          // });
                        },
                        icon: Icon(Icons.favorite_outline, size: 24),
                        selectedIcon: Icon(Icons.favorite, size: 24),
                      ),
                    ),

                    SizedBox(
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: _createRingingCall,
                        icon: Icon(Icons.call_outlined, size: 24, weight: 800),
                        label: Text(
                          "10/min",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 56,
                      child: FilledButton.icon(
                        style: ButtonStyle(
                          iconColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onPrimary,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onPrimary,
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onPressed: _createRingingCall,
                        icon: Icon(
                          Icons.videocam_outlined,
                          size: 28,
                          weight: 800,
                        ),
                        label: Text(
                          "10/min",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
