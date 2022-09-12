part of '../widgets.dart';

class NotificationsCard extends StatelessWidget {
  final NotificationModel notification;
  final HomeworkServices homeworkServices;
  const NotificationsCard({
    Key? key,
    required this.notification,
    required this.homeworkServices,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!notification.seen) {
          await homeworkServices.seeNotification(notification.id);
        }
        if (notification.type == 'new_comment') {
          Navigator.pushNamed(
            context,
            'auctionPage',
            arguments: HomeworkArguments(
              notification.id,
              notification.user.id,
            ),
          );
        }
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
        Container(
          /* color: Colors.yellowAccent, */
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SimpleText(
                text: '045 favorites',
                fontSize: 12,
                color: Colors.black,
              ),
              SimpleText(
                text: timeago.format(notification.createdAt, locale: 'es'),
                fontSize: 12,
                color: Colors.black,
              ),
            ],
          ),
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
