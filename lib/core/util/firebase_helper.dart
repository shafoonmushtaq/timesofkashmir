import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '/features/news/presentation/pages/post_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class FirebaseHelper {
  Future<void> initializeFirebaseUtility() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.subscribeToTopic("all");
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      if (kDebugMode) {
        print("${token}haha");
      }
    });

    if (!kIsWeb) {
      await setupFlutterNotifications();
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print("onMessage: $message");
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      processNavigation(message);
    });
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        processNavigation(value);
      }
    });
  }

  void processNavigation(RemoteMessage message) {
    if (kDebugMode) {
      var data = message.data;
      var navigation = data["navigation"];
      var postId = data["postId"];

      print("onMessageOpenedApp nav: $navigation");
      print("onMessageOpenedApp postId: $postId");
    }

    if (message.data["navigation"] == "/post_screen") {
      Future.delayed(const Duration(milliseconds: 500), () async {
        navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const PostPage(4484)),
        );
      });
    }
  }
}
