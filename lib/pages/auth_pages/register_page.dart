part of '../pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final AuthProvider authService;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    authService = Provider.of<AuthProvider>(context, listen: false);
  }

  void register() async {
    final validationSuccess = _formKey.currentState!.validate();
    /* print(_formKey.currentState!.value['username']); */
    /* print(_formKey.currentState!.value['password']); */
    if (validationSuccess) return;
    _formKey.currentState!.save();
    authService
        .register(
      _formKey.currentState!.value['username'],
      _formKey.currentState!.value['email'],
      _formKey.currentState!.value['password'],
    )
        .then((value) {
      if (value) {
        context.go('/login_page');
        GlobalSnackBar.show(
          context,
          'Registro exitoso, confirma tu correo electrónico, por favor',
        );
        return;
      }
      showSimpleAlert(context, 'hubo un error en el registro');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 30,
              top: 20,
              left: 30.0,
              right: 30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const HeaderLoginRegister(
                      headerTitle: 'Registro',
                    ),
                    FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            const CustomFormBuilderTextField(
                              name: 'username',
                              icon: Icons.person,
                              placeholder: 'Nombre de usuario',
                            ),
                            const CustomFormBuilderTextField(
                              name: 'email',
                              keyboardType: TextInputType.emailAddress,
                              icon: FontAwesomeIcons.at,
                              placeholder: 'Correo electrónico',
                            ),
                            const CustomFormBuilderTextField(
                              name: 'password',
                              icon: FontAwesomeIcons.lock,
                              placeholder: 'Contraseña',
                              passwordField: true,
                            ),
                            const CustomFormBuilderTextField(
                              name: 'password',
                              icon: FontAwesomeIcons.lock,
                              placeholder: 'Repetir contraseña',
                              passwordField: true,
                            ),
                            FormBuilderCheckbox(
                              name: 'accept_terms',
                              initialValue: false,
                              title: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Tengo más de 18 años',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              validator: FormBuilderValidators.equal(
                                true,
                                errorText:
                                    'Debes marcar la casilla de confirmación para continuar',
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                Column(
                  children: [
                    FillButton(
                      label: 'Registrarse',
                      textColor: Colors.white,
                      borderRadius: 50,
                      onPressed: () async {
                        register();
                      },
                    ),
                    const LabelLoginRegister(
                      title: '¿Ya tienes cuenta?',
                      subtitle: 'Iniciar sesión',
                      route: 'login',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
