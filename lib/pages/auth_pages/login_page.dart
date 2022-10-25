part of '../pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    final filter = Provider.of<FilterProvider>(context);
    final socketService = Provider.of<SocketService>(context);
    final notificationService = Provider.of<NotificationService>(context);
    final preferences = UserPreferences();
    final theme = Provider.of<ThemeChanger>(context);

    void loginOk() {
      Navigator.pushReplacementNamed(context, 'bottomNavigation');
      theme.setDarkTheme = authService.user.userProfile.isDarkTheme;
      filter.setCurrentBottomTab = 0;
      notificationService.getUserNotifications();
      socketService.connect();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
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
                      lightThemeColor: Colors.grey,
                      top: 10,
                      bottom: 10,
                    ),
                    LoginButton(
                      onPressed: () async {
                        final googleInfo = await authService.signInWithGoogle();
                        if (googleInfo.correctCredentials) {
                          loginOk();
                        }
                      },
                      paddingVertical: 12,
                      buttonChild: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SimpleText(
                          text: "Iniciar sesión con google",
                          fontSize: 15,
                        ),
                      ),
                      fontSize: 15,
                      backGroundColor:
                          theme.isDarkTheme ? Colors.black38 : Colors.white,
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
                          CustomFormBuilderTextField(
                            name: 'username',
                            icon: FontAwesomeIcons.at,
                            placeholder: 'Nombre de usuario o email',
                          ),
                          CustomFormBuilderTextField(
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
                    authService.getAuthenticating
                        ? const CircularProgressIndicator()
                        : FillButton(
                            label: "Iniciar sesión",
                            textColor: Colors.white,
                            borderRadius: 50,
                            onPressed: () async {
                              final validationSuccess =
                                  _formKey.currentState!.validate();

                              if (validationSuccess) {
                                _formKey.currentState!.save();
                                final login = await authService.login(
                                    _formKey.currentState!.value['username'],
                                    _formKey.currentState!.value['password']);
                                final response = login.message.split(' ')[0];
                                if (response == "login_ok") {
                                  loginOk();
                                } else if (response == "verify_your_email") {
                                  preferences.loginEmail =
                                      login.message.split(' ')[1];
                                  Navigator.pushReplacementNamed(
                                      context, 'verify_email_page');
                                } else {
                                  showSimpleAlert(
                                      context, 'Credenciales incorrectas');
                                }
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
