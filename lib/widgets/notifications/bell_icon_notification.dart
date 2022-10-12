part of '../widgets.dart';

class BellIconNotification extends StatelessWidget {
  const BellIconNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    return Container(
      /* color: Colors.blue, */
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
          /* child: notificationsNotRead > 0 */
          return Badge(
            badgeContent: Text(
              '$notificationsNotRead',
              style: const TextStyle(color: Colors.white),
            ),
            child: iconNotification(context),
          );
        },
      ),
    );
  }

  Widget iconNotification(BuildContext context) {
    return IconButton(
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
