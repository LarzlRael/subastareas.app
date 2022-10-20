part of '../widgets.dart';

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
            child: SizedBox(
                width: double.infinity,
                height: 200,
                child: showProfileImage(profileImage, userName)),
          ),
          Expanded(
            child: _ListOptions(
              onPressedLogout: onPressedLogout,
            ),
          ),
          SafeArea(
            bottom: true,
            top: false,
            left: false,
            right: false,
            child: GestureDetector(
              onTap: () => {
                onPressedLogout(),
                Navigator.pushReplacementNamed(context, 'loading'),
              },
              child: const ListTile(
                leading: Icon(Icons.add_to_home_screen, color: Colors.red),
                title: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget showProfileImage(String? profileImage, String userName,
    {double radius = 30}) {
  return CircleAvatar(
    radius: radius,
    child: profileImage != null
        ? null
        : SimpleText(
            text: convertName(userName),
            fontSize: radius * 0.65,
            lightThemeColor: Colors.white,
          ),
    backgroundImage: profileImage == null ? null : NetworkImage(profileImage),
    backgroundColor: Colors.grey,
  );
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
          /* onPressedLogout(); */
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageRoutes[i].page));
        },
      ),
    );
  }
}
