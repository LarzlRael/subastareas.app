part of '../widgets.dart';

class BellIconNotification extends StatelessWidget {
  const BellIconNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationService = context.read<NotificationProvider>();
    notificationService.getUserNotifications();
    final notificationsNotRead = notificationService.state.notifications
        .where((element) => element.notified == true)
        .toList()
        .length;
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: notificationsNotRead > 0
          ? badges.Badge(
              badgeContent: Text(
                notificationsNotRead > 9 ? '9+' : '$notificationsNotRead',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: iconNotification(context),
            )
          : iconNotification(context),
    );
  }

  Widget iconNotification(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: const Icon(Icons.notifications),
      onPressed: () {
        /* Navigator.pushNamed(context, 'notifications'); */
        /* Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: const NotificationPage()),
        ); */
      },
    );
  }
}
