part of '../pages.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: false);
    final userServices = UserServices();
    final themeChanger = Provider.of<ThemeChanger>(context, listen: true);
    final preferences = UserPreferences();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              auth.logout();
            },
            icon: IconButton(
              onPressed: () {
                auth.logout();
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
        title: const Text('Configuraciones'),
        centerTitle: true,
        /* backgroundColor: isDarkMode(context) ? Colors.black : Colors.white, */
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: showProfileImage(
                  auth.user.profileImageUrl,
                  auth.user.username,
                  radius: 75,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Notificaciones'),
                      trailing: Switch(
                        value: themeChanger.getNotifications,
                        onChanged: (value) {
                          themeChanger.setNotifications = value;
                          /* preferences.notifications = value; */
                        },
                      ),
                      onTap: () {
                        /* auth.logout(); */
                      },
                    ),
                    /* ListTile(
                      leading: const Icon(Icons.person_add_alt),
                      title: const Text('Tema oscuro'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                      onTap: () {
                      },
                    ), */
                    GenericListTile(
                      icon: Icons.color_lens,
                      title: 'Tema oscuro',
                      initialValue: themeChanger.isDarkTheme,
                      onChanged: (value) async {
                        themeChanger.setDarkTheme = value;
                        preferences.setThemeStatus = value ? 0 : 1;
                        final boolxd = await userServices.changeTheme(
                          auth.user.userProfile.id,
                          value ? 0 : 1,
                        );
                        print(boolxd);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Cambiar contraseña'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pushNamed(context, 'change_password');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
