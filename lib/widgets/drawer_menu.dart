part of 'widgets.dart';

class DrawerMenu extends StatelessWidget {
  final Function onPressedLogout;
  final String userName;
  final String profileImage;
  const DrawerMenu({
    Key? key,
    required this.onPressedLogout,
    required this.userName,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              width: double.infinity,
              height: 200,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: profileImage == null
                    ? Text(
                        convertName(userName),
                        style: TextStyle(fontSize: 50),
                      )
                    : FadeInImage(
                        image: NetworkImage(profileImage),
                        placeholder: const AssetImage('assets/icon.png'),
                      ),
              ),
            ),
          ),
          Expanded(
              child: _ListOptions(
            onPressedLogout: onPressedLogout,
          )),
          SafeArea(
            bottom: true,
            top: false,
            left: false,
            right: false,
            child: GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, 'welcome'),
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
  final Function onPressedLogout;

  const _ListOptions({
    Key? key,
    required this.onPressedLogout,
  }) : super(key: key);
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
          onPressedLogout();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageRoutes[i].page));
        },
      ),
    );
  }
}
