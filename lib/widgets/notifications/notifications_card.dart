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
    return ListTile(
      onTap: () async {
        goToPage(
          context,
          notification,
        );
        if (!notification.seen) {
          await notificationBloc.seeNotification(notification.id);
          /* notificationBloc.getNotificationByUser(); */
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
      leading: ShowProfileImage(
        profileImage: notification.user.profileImageUrl,
        userName: notification.user.username,
        radius: 20,
      ),
      title: contentNotification(notification),
      subtitle: SimpleText(
        text: timeago.format(notification.createdAt, locale: 'es'),
        fontSize: 12,
        lightThemeColor: Colors.black,
      ),
      trailing: Icon(
        typeNotification(notification.type).icon,
      ),
      /* child: Ink(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 10,
          ),
          padding: const EdgeInsets.only(
            right: 20,
            /* vertical: 10, */
          ),
          /* color: Colors.yellow, */
          width: MediaQuery.of(context).size.width * 0.2,
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
                typeNotification(notification.type).icon,
              ),
            ],
          ),
        ),
      ), */
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
                text: ' ' + typeNotification(notification.type).type,
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
          ],
        )
      ],
    );
  }
}

class TypeNotification {
  final String type;
  final IconData icon;
  TypeNotification(this.type, this.icon);
}

TypeNotification typeNotification(String type) {
  const map = {
    'new_comment': 'Hizo un comentario',
    'new_offer': 'Hizo una oferta',
    'offer_accepted': 'Acepto tu oferta',
    'homework_finished': 'Termino tu tarea',
    'rejected': 'Rechazaste una oferta',
    'homework_reject': 'Ha rechazado tu tarea',
  };
  const iconMap = {
    'new_comment': FontAwesomeIcons.commentDots,
    'new_offer': FontAwesomeIcons.dollarSign,
    'offer_accepted': FontAwesomeIcons.commentsDollar,
    'homework_finished': FontAwesomeIcons.book,
    'homework_reject': FontAwesomeIcons.ban,
  };
  return TypeNotification(map[type]!, iconMap[type]!);
}

/* Change this for another types */

void goToPage(BuildContext context, NotificationModel notification) {
  switch (notification.type) {
    case 'new_comment':
    case 'new_offer':
      context.push('/homework_detail/${notification.idHomework}');
      break;
    case 'homework_finished':
      context.push('my_homeworks_page', extra: 1);
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
