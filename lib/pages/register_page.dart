part of 'pages.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  RegisterPage({Key? key}) : super(key: key);
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
                SimpleText(text: 'Registrarse'),
                FormBuilderTextField(
                  name: 'username',
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'Nombre de usuario',
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.emailAddress,
                  name: 'email',
                  obscureText: true,
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'Correo electronico',
                    suffixIcon: Icon(Icons.password_outlined),
                  ),
                ),
                FormBuilderTextField(
                  name: 'password',
                  /* obscureText: true, */
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    suffixIcon: Icon(Icons.password_outlined),
                  ),
                ),
                FormBuilderTextField(
                  name: 'confirm_password',
                  /* obscureText: true, */
                  validator: FormBuilderValidators.compose([
                    /// Makes this field required
                    FormBuilderValidators.required(),
                    /* FormBuilderValidators.equal(
                        _formKey.currentState?.value['password']), */
                  ]),
                  decoration: const InputDecoration(
                    labelText: 'Repetir contraseña',
                    suffixIcon: Icon(Icons.password_outlined),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    final validationSuccess = _formKey.currentState!.validate();
                    if (validationSuccess) {
                      /*  _formKey.currentState!.save();
                      await authService.login(
                          _formKey.currentState!.value['username'],
                          _formKey.currentState!.value['password']); */
                    }
                  },
                  child: Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
