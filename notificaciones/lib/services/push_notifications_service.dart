// SHA-1: 9A:68:C0:93:73:68:18:95:C5:A5:98:B5:ED:42:44:DA:23:FE:45:A1

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? token;

  static Future _backgroundHandler(RemoteMessage message) async {
    print("Background Handler ${message.messageId}");
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print("OnMessage Handler ${message.messageId}");
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print("Open App Handler ${message.messageId}");
  }

  static Future initializeApp() async {
    // Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local notifications
  }
}
