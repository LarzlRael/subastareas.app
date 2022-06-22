part of '../widgets.dart';

class BellIconNotification extends StatelessWidget {
  const BellIconNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(0.0),
      child: FutureBuilder(
        future: homeworkServices.getUserNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.hasData) {
            final notificationsNotRead = snapshot.data!
                .where((element) => element.seen == false)
                .toList()
                .length;
            return Stack(
              children: <Widget>[
                iconNotification(context),
                if (snapshot.data!.isNotEmpty)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: notificationsNotRead > 0
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              notificationsNotRead > 9
                                  ? '9+'
                                  : notificationsNotRead.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox(width: 0, height: 0),
                  )
                else
                  const SizedBox(
                    width: 0,
                    height: 0,
                  )
              ],
            );
          } else {
            return iconNotification(context);
          }
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
