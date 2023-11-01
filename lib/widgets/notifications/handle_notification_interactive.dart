part of '../widgets.dart';

class HandleNotificationInteraction extends StatefulWidget {
  final Widget child;
  const HandleNotificationInteraction({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<HandleNotificationInteraction> createState() =>
      _HandleNotificationInteractionState();
}

class _HandleNotificationInteractionState
    extends State<HandleNotificationInteraction> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _handleMessage(RemoteMessage message) {
    context.read<NotificationService>().handleRemoteMessage(message);
    /* final messageId = clearMessageId(message.messageId); */
    /* print('Message ID: $messageId'); */
    final typeContent = message.data['type_content'];
    final idHomework = message.data['id_homework'];
    appRouter.push('/homework_detail/$idHomework');
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
