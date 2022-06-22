part of '../pages.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: true);
    final filter = Provider.of<FilterProvider>(context, listen: true);
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
        items: auth.isLogged ? bottonItemsWithLogin : bottonItemsWithoutLogin,
        currentIndex: filter.getCurrentBottomTab,
        /* selectedItemColor: Colors.amber[800], */
        onTap: (int index) {
          filter.setCurrentBottomTab = index;
        },
      ),
    );
  }
}
