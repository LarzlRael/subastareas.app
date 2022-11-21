part of 'utils.dart';


class NotificationEnum {
  static const new_comment = NotificationEnum._('new_comment');
  static const new_offer = NotificationEnum._('new_offer');
  static const offer_accepted = NotificationEnum._('offer_accepted');
  static const homework_finished = NotificationEnum._('homework_finished');
  static const rejected = NotificationEnum._('rejected');
  static const homework_reject = NotificationEnum._('homework_reject');

  const NotificationEnum._(this.typeNotification);

  final String typeNotification;
}