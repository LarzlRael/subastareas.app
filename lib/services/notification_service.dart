part of 'services.dart';

class PushNotificationInit {
  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    /* await requestPermission(); */
  }

  // Apple / Web
  /* static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    print('User push notification status ${settings.authorizationStatus}');
} */
}

class NotificationProvider with ChangeNotifier {
  NotificationProvider() {
    _onForegroundMessage();
  }
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationState state = NotificationState.initial();
  /* Add feature to see dot if is thre notications */
  bool isSeenNotificationOption = false;

  get getIsSeenNotificationOption => isSeenNotificationOption;
  setIsSeenNotificationOption() {
    isSeenNotificationOption = true;
    notifyListeners();
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    print('onMessage: ${message.notification}');
    final notification = notificationModelFromMap(message.data);
    state = state.copyWith(
      notifications: [notification, ...state.notifications],
    );
    /* final notification = PushMessage(
      messageId: clearMessageId(message.messageId),
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );
    LocalNotification.showLocalNotification(
      id: notification.messageId.hashCode,
      body: notification.body,
      data: notification.messageId,
      title: notification.title,
    );
    add(NotificationsReceived(notification)); */
  }

  Future<void> getUserNotifications() async {
    state = state.copyWith(isLoading: true);
    final notificationRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'devices/getUserNotifications',
    );

    final finalData = notificationsModelFromJson(notificationRequest!.body);

    state = state.copyWith(
      notifications: finalData,
      isLoading: false,
    );
    notifyListeners();
  }

  Future<void> seeNotification(int idNotification) async {
    final seeNotification = await Request.sendRequestWithToken(
      RequestType.put,
      'devices/seeNotification/$idNotification',
    );
    final convertData = notificationModelFromJson(seeNotification!.body);
    state = state.copyWith(
      notifications: state.notifications
          .map((e) => e.id == convertData.id ? convertData : e)
          .toList(),
    );
  }

  Future deleteNotification(int idNotification) async {
    await Request.sendRequestWithToken(
      RequestType.get,
      'devices/deleteNotification/$idNotification',
    );

    state = state.copyWith(
      notifications: state.notifications
          .where((element) => element.id != idNotification)
          .toList(),
    );
    notifyListeners();
  }

  Future clearNotifications() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'devices/clearNotificated',
    );
    return (homeworkRequest!.statusCode);
    /* homeworkRequest!.body; */
  }

  bool notReadNotifications() {
    final notRead =
        state.notifications.where((element) => element.seen == false);
    return notRead.isNotEmpty;
  }

  int notReadNotificationsCount() {
    return state.notifications
        .where((element) => element.seen == false)
        .toList()
        .length;
  }

  String countNotifications() {
    final notRead = notReadNotificationsCount();
    return notRead > 9 ? '9+' : '$notRead';
  }
}

class NotificationState {
  final List<NotificationModel> notifications;
  final bool isLoading;

  factory NotificationState.initial() => NotificationState(
        notifications: [],
        isLoading: false,
      );

  NotificationState({
    required this.notifications,
    required this.isLoading,
  });

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
  }) =>
      NotificationState(
        notifications: notifications ?? this.notifications,
        isLoading: isLoading ?? this.isLoading,
      );
}
