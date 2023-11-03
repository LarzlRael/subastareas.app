part of '../pages.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final mailServices = MailServices();
  String emailField = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            /* crossAxisAlignment: CrossAxisAlignment.start, */
            children: [
              const Center(
                child: Icon(
                  Ionicons.mail_unread,
                  /* color: Colors.blue, */
                  size: 200,
                ),
              ),
              const SimpleText(
                text: 'Recuperación de contraseña',
                fontSize: 23,
                fontWeight: FontWeight.bold,
                lightThemeColor: Colors.black87,
              ),
              const SimpleText(
                top: 20,
                bottom: 20,
                text:
                    'Vamos a enviar un correo electronico para recuperar su contraseña, por favor siga los pasos.',
                lightThemeColor: Colors.black87,
                fontSize: 15,
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: '',
                  decoration:
                      const InputDecoration(labelText: 'Correo electronico'),
                  validator: (value) {
                    if (validateEmail(value!)) {
                      return 'Ingrese un correo electronico válido';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => emailField = value!,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  //TODO send email verification, create service
                  _submit();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  /* crossAxisAlignment: CrossAxisAlignment.center, */
                  children: const [
                    Icon(
                      Ionicons.chevron_forward_circle,
                      size: 30,
                      /* color: Colors.blue, */
                    ),
                    /* const SizedBox(
                      width: 5,
                    ), */
                    SimpleText(
                      text: 'Enviar email de recuperación',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      lightThemeColor: Colors.black87,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    mailServices.requestPasswordChange(emailField).then((value) {
      if (value) {
        GlobalSnackBar.show(
            context, 'Correo enviado, revise su bandeja de entrada',
            backgroundColor: Colors.green);

        context.pop();
      } else {
        GlobalSnackBar.show(context, 'Hubo un error al comprobar su email',
            backgroundColor: Colors.red);
      }
    });
  }
}
