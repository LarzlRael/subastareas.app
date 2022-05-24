part of 'pages.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  int counter = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const ListOpenHomeworks(),
    MyOffers(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Tareas disponibles' : 'Mis ofertas'),
        actions: [
          BellIconNotification(),
        ],
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'homePage');
        },
        tooltip: 'Subir nueva Tarea',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Ofertas',
          ),
        ],
        currentIndex: _selectedIndex,
        /* selectedItemColor: Colors.amber[800], */
        onTap: _onItemTapped,
      ),
    );
  }
}
