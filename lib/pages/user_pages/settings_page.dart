part of '../pages.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: false);

    final themeProvider = context.watch<ThemeProviderNotifier>();

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
                radius: 50,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  /*  ListTile(
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
                  ), */
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
                  /* GenericListTile(
                    icon: Icons.color_lens,
                    title: 'Tema oscuro',
                    initialValue: themeChanger.isDarkTheme,
                    onChanged: (value) async {
                      preferences.setThemeStatus = value ? 0 : 1;
                      themeProvider.toggleTheme();
                      final boolxd = await userServices.changeUserPreferences(
                        auth.user.userProfile.id,
                        themeChanger.getDarkTheme,
                        themeChanger.getNotifications,
                      );
                    },
                  ), */
                  ListTile(
                    leading: const Icon(Icons.color_lens_sharp),
                    title: Text('Tema actual',
                        style: Theme.of(context).textTheme.bodyMedium),
                    trailing: Icon(
                      themeProvider.isDarkModeEnabled
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                    ),
                    onTap: () {
                      /* Navigator.pushNamed(context, 'language'); */
                      themeProvider.toggleTheme();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: Text('Cambiar contraseña',
                        style: Theme.of(context).textTheme.bodyMedium),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.push('/change_password');
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
