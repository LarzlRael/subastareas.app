import 'dart:async';

import 'package:subastareaspp/models/models.dart';
import 'package:subastareaspp/services/services.dart';

class NotificationBloc {
  static final NotificationBloc _singleton = NotificationBloc._internal();
  HomeworkServices homeworkServices = HomeworkServices();

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
        .add(await homeworkServices.getUserNotifications());
  }

  seeNotification(int id) async {
    await homeworkServices.seeNotification(id);
    _notificationController.sink
        .add(await homeworkServices.getUserNotifications());
  }

  deleteNotification(int id) async {
    await homeworkServices.deleteNotification(id);
    _notificationController.sink
        .add(await homeworkServices.getUserNotifications());
  }
}
