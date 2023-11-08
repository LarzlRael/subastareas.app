part of '../widgets.dart';

class NotificationsCard extends StatelessWidget {
  final NotificationModel notification;

  final void Function(NotificationModel notification)? onSelected;
  final void Function(NotificationModel notification)? onHideNotification;
  const NotificationsCard({
    Key? key,
    required this.notification,
    this.onSelected,
    this.onHideNotification,
  }) : super(key: key);

  void showBottomSheetOption(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 60,
          /* color: Colors.amber, */
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.visibility_off_rounded),
                  title: const Text('Ocultar esta notificación',
                      style: TextStyle(fontSize: 14)),
                  onTap: () {
                    if (onHideNotification != null) {
                      onHideNotification!(notification);
                      context.pop();
                    }
                  },
                ),
                /* ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Eliminar'),
                  onTap: () {
                    context.pop();
                  },
                ), */
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (onSelected != null) {
          onSelected!(notification);
        }
      },
      leading: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 3,
        children: [
          notification.seen
              ? const SizedBox()
              : Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
          InkWell(
            onTap: () {
              context.push('/public_profile_page/${notification.user.id}');
            },
            child: ShowProfileImage(
              profileImage: notification.user.profileImageUrl,
              userName: notification.user.username,
              radius: 15,
            ),
          ),
        ],
      ),
      title: contentNotification(context, notification),
      subtitle: SimpleText(
        text: timeago.format(notification.createdAt, locale: 'es'),
        fontSize: 12,
        lightThemeColor: Colors.black,
      ),
      trailing: Wrap(
        /* spacing: 1, */
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            typeNotification(notification.type).icon,
          ),
          InkWell(
            onTap: () {
              showBottomSheetOption(context);
            },
            child: const Icon(
              Icons.more_vert,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget contentNotification(
      BuildContext context, NotificationModel notification) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${notification.user.username} ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextSpan(
                text: typeNotification(notification.type).type,
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
                    text: notification.body.length < 20
                        ? notification.body
                        : notification.body.substring(0, 20),
                    fontSize: 14,
                    lightThemeColor: Colors.black,
                    fontWeight: FontWeight.w400,
                  )
                : const SizedBox(),
            notification.type == 'new_offer'
                ? SimpleText(
                    top: 5,
                    bottom: 5,
                    text: notification.body,
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
    'new_comment': 'hizo un comentario',
    'new_offer': 'hizo una oferta',
    'offer_accepted': 'acepto tu oferta',
    'homework_finished': 'termino tu tarea',
    'rejected': 'rechazaste una oferta',
    'homework_reject': 'ha rechazado tu tarea',
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

void goNotificationDestinyPage(
  BuildContext context,
  NotificationModel notification,
) {
  switch (notification.type) {
    case 'new_comment':
      context.push('/homework_detail/${notification.idHomework}');
      break;
    case 'new_offer':
      context.push('/auction_with_offerPage/${notification.idHomework}');
      break;
    case 'homework_finished':
      context.push('/my_homeworks_page', extra: 1);
      break;
    case 'offer_accepted':
      context.push('/pending_homeworks_offers_accepts');
      break;
    default:
  }
}
