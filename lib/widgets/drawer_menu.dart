part of 'widgets.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageRoutes[i].page));
        },
      ),
    );
  }
}
