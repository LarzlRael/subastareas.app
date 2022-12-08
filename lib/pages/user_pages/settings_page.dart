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
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Configuraciones',
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ShowProfileImage(
                profileImage: auth.user.profileImageUrl,
                userName: auth.user.username,
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
                      onChanged: (value) async {
                        themeChanger.setNotifications = value;
                        await userServices.changeUserPreferences(
                          auth.user.userProfile.id,
                          themeChanger.getDarkTheme,
                          themeChanger.getNotifications,
                        );
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
                      final boolxd = await userServices.changeUserPreferences(
                        auth.user.userProfile.id,
                        themeChanger.getDarkTheme,
                        themeChanger.getNotifications,
                      );
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
    );
  }
}
