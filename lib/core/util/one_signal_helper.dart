import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:timesofkashmir/core/util/firebase_helper.dart';
import 'package:timesofkashmir/features/news/presentation/pages/post_page.dart';

class OneSignalHelper {
  final String id;

  OneSignalHelper(this.id);

  Future<void> initOneSignalUtility() async {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(id);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      processNavigation(result.notification.additionalData);
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }

  void processNavigation(Map<String, dynamic>? data) {
    if (data?["navigation"] == "/post_screen") {
      int postId = int.tryParse(data?["postId"]) ?? 4484;
      Future.delayed(const Duration(milliseconds: 1500), () async {
        navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => PostPage(postId)),
            (Route<dynamic> route) => false);
      });
    }
  }
}
