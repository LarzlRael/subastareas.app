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
    const HomePage(),
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
      drawer: _MenuPrincipal(),
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

class _MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              width: double.infinity,
              height: 200,
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  'FH',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
          ),
          Expanded(child: _ListOptions()),
          SafeArea(
            bottom: true,
            top: false,
            left: false,
            right: false,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'welcome'),
              child: const ListTile(
                leading: Icon(Icons.add_to_home_screen, color: Colors.blue),
                title: Text('Cerrar sesión'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, i) => const Divider(
        color: Colors.grey,
      ),
      itemCount: pageRoutes.length,
      itemBuilder: (context, i) => ListTile(
        leading: FaIcon(
          pageRoutes[i].icon,
        ),
        title: Text(pageRoutes[i].titulo),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: () {
          /* Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageRoutes[i].page)); */
        },
      ),
    );
  }
}
