part of '../pages.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const HeaderLoginRegister(
                        headerTitle: 'Iniciar sesión',
                      ),
                      const SimpleText(
                        text: 'o',
                        fontSize: 20,
                        color: Colors.grey,
                        top: 10,
                        bottom: 10,
                      ),
                      LoginButton(
                        onPressed: () async {
                          var googleinfo =
                              await GoogleSignInServices.signiWithGoogle();
                        },
                        text: "Iniciar sesión con google",
                        backGroundColor: Colors.white,
                        icon: SvgPicture.asset(
                          'assets/svg/google_icon.svg',
                          width: 30,
                          height: 30,
                        ),
                        textColor: Colors.black87,
                      ),
                      const CustomFormbuilderTextField(
                        name: 'username',
                        icon: FontAwesomeIcons.at,
                        placeholder: 'Nombre de usuario o email',
                      ),
                      const CustomFormbuilderTextField(
                        name: 'password',
                        icon: FontAwesomeIcons.lock,
                        placeholder: 'Contraseña',
                        passwordField: true,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      LoginButton(
                        text: "Iniciar sesión",
                        textColor: Colors.white,
                        showIcon: false,
                        onPressed: () async {
                          final validationSuccess =
                              _formKey.currentState!.validate();
                          print(_formKey.currentState!.value['username']);
                          print(_formKey.currentState!.value['password']);
                          if (validationSuccess) {
                            _formKey.currentState!.save();
                            /* Navigator.pushReplacementNamed(
                                context, 'bottomNavigation'); */
                            final login = await authService.login(
                                _formKey.currentState!.value['username'],
                                _formKey.currentState!.value['password']);

                            if (login) {
                              Navigator.pushReplacementNamed(
                                  context, 'bottomNavigation');
                            } else {
                              showSimpleAlert(
                                  context, 'Credenciales incorrectas');
                            }
                          }
                        },
                      ),
                      const LabelLoginRegister(
                        title: '¿No tienes cuenta?',
                        subtitle: 'Registrate',
                        route: 'register',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
