part of '../pages.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late AuthServices authService;
  late SocketService socketService;
  late UserPreferences preferences;
  late MailServices mailServices;
  @override
  void initState() {
    authService = Provider.of<AuthServices>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    mailServices = MailServices();
    preferences = UserPreferences();
    mailServices.requestEmailVerification(preferences.loginEmail);
    super.initState();
  }

  @override
  void dispose() {
    preferences.loginEmail = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            /* crossAxisAlignment: CrossAxisAlignment.start, */
            children: [
              const Center(
                  child: Icon(
                Ionicons.mail_open_outline,
                color: Colors.blue,
                size: 150,
              )),
              const SimpleText(
                text: 'Verifica tu cuenta',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                bottom: 10,
              ),
              SimpleText(
                text: preferences.loginEmail,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              const SimpleText(
                top: 10,
                text:
                    'Por favor complete su verificación de identidad de correo electronico, acabamos de enviarle un email a su cuenta ',
                bottom: 20,
              ),
              GestureDetector(
                  onTap: () {
                    sendEmailVerification(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Ionicons.chevron_forward_circle,
                          size: 35,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const SimpleText(
                        text: 'Reenviar E-mail de verificación',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  if (authService.isLogged) {
                    Navigator.pushReplacementNamed(context, 'loading');
                  } else {
                    GlobalSnackBar.show(
                      context,
                      'Por favor verifica tu email',
                      backgroundColor: Colors.red,
                    );
                  }
                },
                child: const SimpleText(text: 'Ya verifique mi cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  sendEmailVerification(BuildContext context) async {
    final isSended =
        await mailServices.requestEmailVerification(preferences.loginEmail);
    if (isSended) {
      GlobalSnackBar.show(
        context,
        'Correo electronico enviado, verifique su email',
        backgroundColor: Colors.green,
      );
    } else {
      GlobalSnackBar.show(
        context,
        'Hubo un error al enviar el correo electronico',
        backgroundColor: Colors.red,
      );
    }
    Navigator.pop(context);
  }
}
