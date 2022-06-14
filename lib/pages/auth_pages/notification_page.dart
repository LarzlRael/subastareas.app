part of '../pages.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tus Notificaciones")),
      body: Center(
        child: NoInformation(
          icon: Icons.notifications_off,
          message: "No tienes notificaciones",
          showButton: false,
          iconButton: Icons.add,
        ),
      ),
    );
  }
}
