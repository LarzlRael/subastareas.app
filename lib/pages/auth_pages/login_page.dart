part of '../pages.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    final filter = Provider.of<FilterProvider>(context);
    final socketService = Provider.of<SocketService>(context);
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
                      loading: _loading,
                      onPressed: () async {
                        //TODO redirect to main menu
                        final googleinfo =
                            await GoogleSignInServices.signiWithGoogle();
                      },
                      paddingVertical: 12,
                      text: "Iniciar sesión con google",
                      fontSize: 15,
                      backGroundColor: Colors.white,
                      icon: SvgPicture.asset(
                        'assets/svg/google_icon.svg',
                        width: 25,
                        height: 25,
                      ),
                      textColor: Colors.black87,
                    ),
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: const [
                          CustomFormbuilderTextField(
                            name: 'username',
                            icon: FontAwesomeIcons.at,
                            placeholder: 'Nombre de usuario o email',
                          ),
                          CustomFormbuilderTextField(
                            name: 'password',
                            icon: FontAwesomeIcons.lock,
                            placeholder: 'Contraseña',
                            passwordField: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    LoginButton(
                        text: "Iniciar sesión",
                        textColor: Colors.white,
                        showIcon: false,
                        loading: _loading,
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          final validationSuccess =
                              _formKey.currentState!.validate();

                          if (validationSuccess) {
                            _formKey.currentState!.save();
                            final login = await authService.login(
                                _formKey.currentState!.value['username'],
                                _formKey.currentState!.value['password']);

                            if (login) {
                              Navigator.pushReplacementNamed(
                                  context, 'bottomNavigation');
                              filter.setCurrentBottomTab = 0;
                              socketService.connect();
                            } else {
                              showSimpleAlert(
                                  context, 'Credenciales incorrectas');
                            }
                            setState(() {
                              _loading = false;
                            });
                          }
                        }),
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
    );
  }
}
