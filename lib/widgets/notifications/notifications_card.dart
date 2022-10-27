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
    return InkWell(
      onTap: () async {
        goToPage(
          context,
          notification,
        );
        if (!notification.seen) {
          await notificationBloc.seeNotification(notification.id);
          notificationBloc.getNotificationByUser();
        }
      },
      onLongPress: () {
        showConfirmDialog(
          context,
          'Eliminar notificacion',
          '¿Estás seguro de quiere eliminar esta notification?',
          () => notificationBloc.deleteNotification(notification.id),
        );
      },
      /* TODO fix view */
      child: Ink(
        child: Container(
          /* color: Colors.purple, */
          margin: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 10,
          ),
          /* color: Colors.yellow, */
          width: double.infinity,
          /* height: 75, */
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                /* crossAxisAlignment: CrossAxisAlignment.center, */
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: notification.seen
                              ? Colors.transparent
                              : Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      /* const SizedBox(width: 5), */

                      ShowProfileImage(
                        profileImage: notification.user.profileImageUrl,
                        userName: notification.user.username,
                        radius: 20,
                      ),
                      const SizedBox(
                        width: 10,
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
                  ),
                ],
              ),
              Icon(
                iconType(notification.type),
              ),
            ],
          ),
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
            children: [
              TextSpan(
                text: notification.user.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextSpan(
                text: ' ' + typeNotification(notification.type),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
        ),
        /* const SizedBox(height: 5), */
        Column(
          /* mainAxisAlignment: MainAxisAlignment.start, */
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            notification.type == 'new_comment'
                ? SimpleText(
                    top: 5,
                    bottom: 5,
                    text: notification.content.length < 20
                        ? notification.content
                        : notification.content.substring(0, 20),
                    fontSize: 14,
                    lightThemeColor: Colors.black,
                    fontWeight: FontWeight.w400,
                  )
                : const SizedBox(),
            notification.type == 'new_offer'
                ? SimpleText(
                    top: 5,
                    bottom: 5,
                    text: 'Oferta: ' + notification.offerAmount.toString(),
                    fontSize: 14,
                    lightThemeColor: Colors.black,
                    fontWeight: FontWeight.w400,
                  )
                : const SizedBox(),
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

/* Change this for another types */
IconData iconType(String type) {
  switch (type) {
    case 'new_comment':
      return FontAwesomeIcons.commentDots;
    case 'new_offer':
      return FontAwesomeIcons.dollarSign;
    case 'offer_accepted':
      return FontAwesomeIcons.commentsDollar;
    case 'homework_finished':
      return FontAwesomeIcons.book;
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
          notification.idHomework,
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
