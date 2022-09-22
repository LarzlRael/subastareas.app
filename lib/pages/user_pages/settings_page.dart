part of '../pages.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: false);
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
        title: const Text('Configuración'),
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
                child: CircleAvatar(
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
                    ListTile(
                      leading: const Icon(Icons.person_add_alt),
                      title: const Text('Tema oscuro'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                      onTap: () {
                        /* auth.logout(); */
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Cambiar contraseña'),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          /* Navigator.pushNamed(context, 'changePasswordPage'); */
                        },
                      ),
                      onTap: () {
                        /* auth.logout(); */
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
