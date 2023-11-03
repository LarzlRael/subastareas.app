part of '../widgets.dart';

class BellIconNotification extends StatelessWidget {
  const BellIconNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationService = context.read<NotificationProvider>()
      ..getUserNotifications();

    final notificationsNotRead = notificationService.state.notifications
        .where((element) => element.seen == true)
        .toList()
        .length;
    final notRead = notificationsNotRead > 9 ? '9+' : '$notificationsNotRead';
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: notificationsNotRead > 0
          ? badges.Badge(
              badgeContent: Text(
                notRead,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: iconNotification(true),
            )
          : iconNotification(false),
    );
  }

  Widget iconNotification(bool isThereNotifications) {
    return Icon(
      isThereNotifications ? Icons.notifications : FontAwesomeIcons.bell,
      /* size: 20, */
      /* color: Theme.of(context).primaryColor, */
    );
  }
}
