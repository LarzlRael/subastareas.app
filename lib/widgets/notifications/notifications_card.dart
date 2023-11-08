part of '../widgets.dart';

class NotificationsCard extends StatelessWidget {
  final NotificationModel notification;

  final void Function(NotificationModel homework)? onSelected;
  final void Function(NotificationModel homework)? onLongPressSelected;
  const NotificationsCard({
    Key? key,
    required this.notification,
    this.onSelected,
    this.onLongPressSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: notification.seen ? Colors.white : Colors.grey[200],
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: () {
          if (onSelected != null) {
            onSelected!(notification);
          }
        },
        onLongPress: () {
          if (onLongPressSelected != null) {
            onLongPressSelected!(notification);
          }
        },
        /* TODO fix view */
        leading: InkWell(
          onTap: () {
            context.push('/public_profile_page/${notification.user.id}');
          },
          child: ShowProfileImage(
            profileImage: notification.user.profileImageUrl,
            userName: notification.user.username,
            radius: 16,
          ),
        ),
        title: contentNotification(context, notification),
        subtitle: SimpleText(
          text: timeago.format(notification.createdAt, locale: 'es'),
          fontSize: 12,
          lightThemeColor: Colors.black,
        ),
        trailing: Icon(
          typeNotification(notification.type).icon,
        ),
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
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context
                        .push('/public_profile_page/${notification.user.id}');
                  },
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
      context.push('my_homeworks_page', extra: 1);
      break;
    case 'offer_accepted':
      context.push('/pending_homeworks_offers_accepts');
      break;
    default:
  }
}
