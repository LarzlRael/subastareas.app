part of 'services.dart';

class NotificationService with ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final _storage = const FlutterSecureStorage();

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  Future<List<NotificationModel>> getUserNotifications() async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'devices/getUserNotifications',
      {},
      await _storage.read(key: 'token'),
    );

    final finalData = notificationModelFromJson(homeworkRequest!.body);
    _notifications = finalData;
    notifyListeners();
    return finalData;
  }

  Future<void> seeNotification(int idNotification) async {
    await Request.sendRequestWithToken(
      'PUT',
      'devices/seeNotification/$idNotification',
      {},
      await _storage.read(key: 'token'),
    );
  }

  Future deleteNotification(int idNotification) async {
    final homeworkRequest = await Request.sendRequestWithToken(
      'GET',
      'devices/deleteNotification/$idNotification',
      {},
      await _storage.read(key: 'token'),
    );

    return (homeworkRequest!.statusCode);
    /* homeworkRequest!.body; */
  }
}
