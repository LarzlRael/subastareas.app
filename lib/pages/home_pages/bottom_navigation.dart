part of '../pages.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  int counter = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    /* CategoriesPage(), */
    const ListOpenHomeworks(),
    UploadHomework(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: true);

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: auth.isLogged
          ? DrawerMenu(
              onPressedLogout: auth.logout,
              userName: auth.usuario.username,
              profileImage: auth.usuario.profileImageUrl,
            )
          : null,
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
        items: bottonItems,
        currentIndex: _selectedIndex,
        /* selectedItemColor: Colors.amber[800], */
        onTap: _onItemTapped,
      ),
    );
  }
}
