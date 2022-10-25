part of '../widgets.dart';

class BellIconNotification extends StatelessWidget {
  const BellIconNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: FutureBuilder(
        future: homeworkServices.getUserNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (!snapshot.hasData) {
            return iconNotification(context);
          }
          final notificationsNotRead = snapshot.data!
              .where((element) => element.notified == true)
              .toList()
              .length;
          return notificationsNotRead > 0
              ? Badge(
                  badgeContent: Text(
                    notificationsNotRead > 9 ? '9+' : '$notificationsNotRead',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  child: iconNotification(context),
                )
              : iconNotification(context);
        },
      ),
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
