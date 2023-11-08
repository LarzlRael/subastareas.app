part of '../pages.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late NotificationProvider notificationProvider;
  @override
  initState() {
    super.initState();
    notificationProvider = context.read<NotificationProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Notificaciones',
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, value, child) {
          final notificationState = value.state;
          return notificationState.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : notificationState.notifications.isEmpty
                  ? const Center(
                      child: NoInformation(
                        icon: Icons.notifications_off,
                        message: "No tienes notificaciones",
                        showButton: false,
                        iconButton: Icons.add,
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          notificationProvider.state.notifications.length,
                      itemBuilder: (_, int index) {
                        final notificationIndex =
                            notificationProvider.state.notifications[index];
                        return NotificationsCard(
                          notification: notificationIndex,
                          onHideNotification: (selected) {
                            notificationProvider
                                .deleteNotification(selected.id);
                          },
                          onSelected: (selected) {
                            if (!selected.seen) {
                              notificationProvider
                                  .seeNotification(selected.id)
                                  .then((value) {
                                goNotificationDestinyPage(
                                    context, selected.type, selected.id);
                              });
                            } else {
                              goNotificationDestinyPage(
                                  context, selected.type, selected.id);
                            }
                          },
                        );
                      },
                    );
        },
      ),
    );
  }
}
