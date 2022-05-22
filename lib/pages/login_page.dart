part of 'pages.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                const SimpleText(text: 'Iniciar sesión'),
                FormBuilderTextField(
                  name: 'username',
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'Nombre de usuario',
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    suffixIcon: Icon(Icons.password_outlined),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    final validationSuccess = _formKey.currentState!.validate();
                    if (validationSuccess) {
                      _formKey.currentState!.save();
                      final login = await authService.login(
                          _formKey.currentState!.value['username'],
                          _formKey.currentState!.value['password']);

                      if (login) {
                        Navigator.pushReplacementNamed(context, 'homePage');
                      } else {
                        showSimpleAlert(context, 'Credenciales incorrectas');
                      }
                    }
                  },
                  child: Text('Iniciar sesión'),
                ),
                RaisedButton(
                  onPressed: () async {
                    await authService.logout();
                  },
                  child: Text('Cerrar sesion'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
