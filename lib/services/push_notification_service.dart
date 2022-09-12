part of 'services.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();
  static Stream<String> get messageStream => _messageStreamController.stream;
  static Future _backgroundHandler(RemoteMessage message) async {
    print('backgroundHandler: ${message.messageId}');
    _messageStreamController.add(message.notification?.title ?? 'no title');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('onMessage: ${message.messageId}');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenApp: ${message.messageId}');
    _messageStreamController.add(message.notification?.title ?? 'no title');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStream() {
    _messageStreamController.close();
  }
}
