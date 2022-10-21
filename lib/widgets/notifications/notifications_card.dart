part of '../widgets.dart';

class NotificationsCard extends StatelessWidget {
  final NotificationModel notification;
  final NotificationBloc notificationBloc;
  const NotificationsCard({
    Key? key,
    required this.notification,
    required this.notificationBloc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!notification.seen) {
          await notificationBloc.seeNotification(notification.id);
        }

        goToPage(
          context,
          notification,
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 75,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: notification.seen ? Colors.transparent : Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  child: showProfileImage(notification.user.profileImageUrl,
                      notification.user.username,
                      radius: 20),
                ),
              ],
            ),
            contentNotification(notification),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                /* color: Colors.red, */
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  iconType(notification.type),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contentNotification(NotificationModel notification) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            /* text: 'Nombre ', */
            /* style: DefaultTextStyle.of(context).style, */
            children: [
              TextSpan(
                  text: notification.user.username,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              TextSpan(
                text: ' ' + typeNotification(notification.type),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SimpleText(
              text: ' ',
              fontSize: 12,
              lightThemeColor: Colors.black,
            ),
            SimpleText(
              text: timeAgo.format(notification.createdAt, locale: 'es'),
              fontSize: 12,
              lightThemeColor: Colors.black,
            ),
          ],
        )
      ],
    );
  }
}

String typeNotification(String type) {
  switch (type) {
    case 'new_comment':
      return 'Hizo un comentario';
    case 'new_offer':
      return 'Hizo una oferta';
    case 'offer_accepted':
      return 'Acepto tu oferta';
    case 'homework_finished':
      return 'termino tu tarea';
    case 'rejected':
      return 'Rechazaste una oferta';
    default:
      return 'Notification';
  }
}

IconData iconType(String type) {
  switch (type) {
    case 'new_comment':
      return FontAwesomeIcons.commentDots;
    case 'new_offer':
      return FontAwesomeIcons.dollarSign;
    case 'offer_accepted':
      return FontAwesomeIcons.commentsDollar;
    default:
      return FontAwesomeIcons.dollarSign;
  }
}

void goToPage(BuildContext context, NotificationModel notification) {
  switch (notification.type) {
    case 'new_comment':
    case 'new_offer':
      Navigator.pushNamed(
        context,
        'auctionPage',
        arguments: HomeworkArguments(
          notification.id,
          notification.user.id,
        ),
      );
      break;
    case 'homework_finished':
      Navigator.pushNamed(
        context,
        'my_homeworks_page',
        arguments: 1,
      );
      break;
    case 'offer_accepted':
      Navigator.pushNamed(
        context,
        'pending_homeworks_offers_accepts',
      );
      break;
    default:
  }
}
