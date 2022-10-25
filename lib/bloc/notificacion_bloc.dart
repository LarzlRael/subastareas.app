import 'dart:async';

import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/services/services.dart';

class NotificationBloc {
  static final NotificationBloc _singleton = NotificationBloc._internal();
  NotificationService notificationService = NotificationService();

  factory NotificationBloc() {
    return _singleton;
  }
  NotificationBloc._internal();

  final _notificationController =
      StreamController<List<NotificationModel>>.broadcast();

  Stream<List<NotificationModel>> get notificationStream =>
      _notificationController.stream;

  dispose() {
    _notificationController.close();
  }

  getNotificationByUser() async {
    _notificationController.sink
        .add(await notificationService.getUserNotifications());
  }

  seeNotification(int id) async {
    await notificationService.seeNotification(id);
    _notificationController.sink
        .add(await notificationService.getUserNotifications());
  }

  deleteNotification(int id) async {
    await notificationService.deleteNotification(id);
    _notificationController.sink
        .add(await notificationService.getUserNotifications());
  }
}
