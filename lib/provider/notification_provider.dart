part of './providers.dart';

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

    final notification =
        notificationModelFromJson(message.data['data_from_server']);

    LocalNotification.showLocalNotification(notification);
    state = state.copyWith(
      notifications: [notification, ...state.notifications],
    );
    notifyListeners();
    countNotifications();
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
    countNotifications();

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
    countNotifications();
    notifyListeners();
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

  countNotifications() {
    final countNotRead = state.notifications
        .where((element) => element.seen == false)
        .toList()
        .length;
    state = state.copyWith(
      noReadNotificationCount: countNotRead,
    );
    notifyListeners();

    final noReadDisplay = state.noReadNotificationCount > 9
        ? '9+'
        : '${state.noReadNotificationCount}';

    state = state.copyWith(
      noReadNotificationCountToDisplay: noReadDisplay,
    );
    notifyListeners();
  }
}

class NotificationState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String noReadNotificationCountToDisplay;
  final int noReadNotificationCount;

  factory NotificationState.initial() => NotificationState(
        notifications: [],
        isLoading: false,
        noReadNotificationCountToDisplay: '0',
        noReadNotificationCount: 0,
      );

  NotificationState({
    required this.notifications,
    required this.isLoading,
    required this.noReadNotificationCountToDisplay,
    required this.noReadNotificationCount,
  });

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? noReadNotificationCountToDisplay,
    int? noReadNotificationCount,
  }) =>
      NotificationState(
        notifications: notifications ?? this.notifications,
        isLoading: isLoading ?? this.isLoading,
        noReadNotificationCountToDisplay: noReadNotificationCountToDisplay ??
            this.noReadNotificationCountToDisplay,
        noReadNotificationCount:
            noReadNotificationCount ?? this.noReadNotificationCount,
      );
}
