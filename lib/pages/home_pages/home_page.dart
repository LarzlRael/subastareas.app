part of '../pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    final filter = context.read<GlobalProvider>();
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: auth.isLogged
            ? bottomItemsWithLogin.elementAt(filter.getCurrentBottomTab)
            : bottomItemsWithoutLogin.elementAt(filter.getCurrentBottomTab),
      ),
      /*   drawer: auth.isLogged
          ? DrawerMenu(
              onPressedLogout: auth.logout,
              userName: auth.user.username,
              profileImage: '')
          : null, */
      /* floatingActionButton: auth.isLogged
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'homePage');
              },
              tooltip: 'Subir nueva tarea',
              child: const Icon(Icons.add),
            )
          : null, */
      bottomNavigationBar: BottomNavigationBar(
        items: auth.isLogged
            ? bottonItemsWithLogin(notificationProvider.notReadNotifications())
            : bottonItemsWithoutLogin,
        currentIndex: filter.getCurrentBottomTab,
        /* selectedItemColor: Colors.amber[800], */
        onTap: (int index) {
          filter.setCurrentBottomTab = index;
        },
      ),
    );
  }
}
