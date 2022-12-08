part of 'utils.dart';

class NotificationEnum {
  static const newComment = NotificationEnum._('new_comment');
  static const newOffer = NotificationEnum._('new_offer');
  static const offerAccepted = NotificationEnum._('offer_accepted');
  static const homeworkFinished = NotificationEnum._('homework_finished');
  static const rejected = NotificationEnum._('rejected');
  static const homeworkReject = NotificationEnum._('homework_reject');

  const NotificationEnum._(this.typeNotification);

  final String typeNotification;
}
