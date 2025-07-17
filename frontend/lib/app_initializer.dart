import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frontend/app_keys.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/tutorial_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:stream_video_push_notification/stream_video_push_notification.dart';

class AppInitializer {
  static const storedUserKey = 'zK8Y4fTYAOXa2WDDVjekzXzHJO92';

  static Future<TutorialUser?> getStoredUser() async {
    final storage = FlutterSecureStorage();

    final userId = await storage.read(key: storedUserKey);
    if (userId == null) {
      return null;
    }

    return TutorialUser.users.firstWhere((user) => user.user.id == userId);
  }

  static Future<void> storeUser(TutorialUser tutorialUser) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: storedUserKey, value: tutorialUser.user.id);
  }

  static Future<void> clearStoredUser() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: storedUserKey);
  }

  static Future<StreamVideo> init(TutorialUser tutorialUser) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");

    final client = StreamVideo(
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
    );

    // if (token != null) {
    //   await client.pushNotifications.setDevice(token);
    // }

    client.connect();
    return client;
  }
}
