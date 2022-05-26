part of 'pages.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tus Notificaciones")),
      body: Center(
        child: Text('NotificationPage'),
      ),
    );
  }
}
