part of '../pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthServices authService;
  @override
  void initState() {
    authService = Provider.of<AuthServices>(context, listen: false);
    super.initState();
  }

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterProvider>(context);
    final socketService = Provider.of<SocketService>(context);
    final notificationService =
        Provider.of<NotificationProvider>(context, listen: false);
    final preferences = UserPreferences();

    void loginOk() {
      context.go('/home_page');
      /* theme.setDarkTheme = authService.user.userProfile.isDarkTheme; */
      filter.setCurrentBottomTab = 0;
      notificationService.getUserNotifications();
      socketService.connect();
    }

    void initLogin(GlobalKey<FormBuilderState> formKey) async {
      final validationSuccess = _formKey.currentState!.validate();

      if (!validationSuccess) return;
      formKey.currentState!.save();
      authService
          .login(_formKey.currentState!.value['username'],
              _formKey.currentState!.value['password'])
          .then((res) {
        final response = res.message.split(' ')[0];
        if (response == "login_ok") {
          loginOk();
        }
        if (response == "verify_your_email") {
          preferences.loginEmail = res.message.split(' ')[1];
          context.go('/verify_email_page');
        }
        showSimpleAlert(context, 'Credenciales incorrectas');
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          setUniqueColor: true,
                          lightThemeColor: Colors.white,
                          text: "Iniciar sesión con google",
                          fontSize: 15,
                        ),
                      ),
                      fontSize: 15,
                      /*  backGroundColor:
                          theme.isDarkTheme ? Colors.black38 : Colors.white, */
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
                        children: [
                          const CustomFormBuilderTextField(
                            name: 'username',
                            icon: FontAwesomeIcons.at,
                            placeholder: 'Nombre de usuario o email',
                          ),
                          const CustomFormBuilderTextField(
                            name: 'password',
                            icon: FontAwesomeIcons.lock,
                            placeholder: 'Contraseña',
                            passwordField: true,
                          ),
                          authService.getAuthenticating
                              ? const CircularProgressIndicator()
                              : FillButton(
                                  label: "Iniciar sesión",
                                  textColor: Colors.white,
                                  borderRadius: 50,
                                  onPressed: () async {
                                    initLogin(_formKey);
                                  },
                                ),
                        ],
                      ),
                    )
                  ],
                ),
                const Column(
                  children: [
                    LabelLoginRegister(
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
