part of 'services.dart';

class NotificationService with ChangeNotifier {
  NotificationService() {
    _onForegroundMessage();
  }
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    print('onMessage: ${message.notification}');
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

  Future<List<NotificationModel>> getUserNotifications() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'devices/getUserNotifications',
    );

    final finalData = notificationModelFromJson(homeworkRequest!.body);
    _notifications = finalData;
    notifyListeners();
    return finalData;
  }

  Future<void> seeNotification(int idNotification) async {
    await Request.sendRequestWithToken(
      RequestType.put,
      'devices/seeNotification/$idNotification',
    );
  }

  Future deleteNotification(int idNotification) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'devices/deleteNotification/$idNotification',
    );

    return (homeworkRequest!.statusCode);
    /* homeworkRequest!.body; */
  }

  Future clearNotifications() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'devices/clearNotificated',
    );
    return (homeworkRequest!.statusCode);
    /* homeworkRequest!.body; */
  }
}
