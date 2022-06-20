part of '../pages.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    homeworkServices.getUserNotifications();
    return Scaffold(
      appBar: AppBar(title: Text("Notificaciones")),
      body: /* Center(
        child: NoInformation(
          icon: Icons.notifications_off,
          message: "No tienes notificaciones",
          showButton: false,
          iconButton: Icons.add,
        ), */
          FutureBuilder(
        future: homeworkServices.getUserNotifications(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationsCard(
                  notification: snapshot.data[index],
                  homeworkServices: homeworkServices,
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
