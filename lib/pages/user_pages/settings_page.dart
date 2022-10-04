part of '../pages.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: false);
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
                child: const CircleAvatar(
                  radius: 65.0,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Notificationes'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
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
                      icon: Icons.person_add_alt,
                      title: 'Tema oscuro',
                      initialValue: themeChanger.isDarkTheme,
                      onChanged: (value) {
                        themeChanger.setDarkTheme = value;
                        preferences.setThemeStatus = value ? 1 : 0;
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Cambiar contraseña'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        /* Navigator.pushNamed(context, 'forgot_password'); */
                        /* TODO create page to change password from here */
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
