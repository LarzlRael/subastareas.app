part of '../pages.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    homeworkServices.getUserNotifications();

    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      body: FutureBuilder(
        future: homeworkServices.getUserNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              const Center(
                child: NoInformation(
                  icon: Icons.notifications_off,
                  message: "No tienes notificaciones",
                  showButton: false,
                  iconButton: Icons.add,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationsCard(
                  notification: snapshot.data![index],
                  homeworkServices: homeworkServices,
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
