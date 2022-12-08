part of '../pages.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
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
                                        fontSize: 18,
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
                        final validationSuccess =
                            _formKey.currentState!.validate();
                        /* print(_formKey.currentState!.value['username']); */
                        /* print(_formKey.currentState!.value['password']); */
                        if (validationSuccess) {
                          _formKey.currentState!.save();
                          final login = await authService.register(
                            _formKey.currentState!.value['username'],
                            _formKey.currentState!.value['email'],
                            _formKey.currentState!.value['password'],
                          );

                          if (login) {
                            Navigator.pushReplacementNamed(context, 'login');
                            GlobalSnackBar.show(
                              context,
                              'Registro exitoso, confirma tu correo electrónico, por favor',
                            );
                          } else {
                            showSimpleAlert(
                                context, 'hubo un error en el registro');
                          }
                        }
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
