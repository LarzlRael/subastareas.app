part of '../pages.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late AuthServices authService;
  late SocketService socketService;
  late UserModel user;

  @override
  Widget build(BuildContext context) {
    authService = Provider.of<AuthServices>(context, listen: false);
    //TODO
    socketService = Provider.of<SocketService>(context, listen: false);
    user = authService.user;
    /* mailServices = MailServices(); */

    /* mailServices.sendEmailVerification(authService.usuario.email); */

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
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

              /* Text(
                '${usuario.email}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ), */

              const SimpleText(
                top: 10,
                text:
                    'Por favor complete su verificacion de identidad de correo electronico, acabamos de enviarle un email a su cuenta ',
                bottom: 20,
              ),
              GestureDetector(
                /* onTap: () {
                  sendEmailVerication(context);
                }, */
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(
                      width: 10,
                    ),
                    const SimpleText(
                        top: 10,
                        text: 'Reenviar e-mail de verificación',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  /* await this.authService.isLoggenIn(); */
                  if (authService.isLogged) {
                    Navigator.pushReplacementNamed(context, 'home');
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

  /* sendEmailVerication(BuildContext context) {
    this.mailServices.sendEmailVerification(authService.usuario.email);
    showSnackBarNotification(
        color: Colors.green,
        message: 'Correo electronico enviado, verifique su email',
        context: context);
    /* Navigator.pop(context); */
  } */
}
