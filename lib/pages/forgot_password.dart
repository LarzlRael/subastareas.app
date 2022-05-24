part of 'pages.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  String emailField = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              /* crossAxisAlignment: CrossAxisAlignment.start, */
              children: [
                const Center(
                    child: Icon(
                  Ionicons.mail_unread,
                  color: Colors.blue,
                  size: 200,
                )),
                const SimpleText(
                  text: 'Recuperación de contraseña',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                const SimpleText(
                  top: 20,
                  bottom: 20,
                  text:
                      'Vamos a enviar un correo electronico para recuperar su contraseña, por favor siga los pasos .',
                  color: Colors.black87,
                  fontSize: 15,
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
                        return 'Ingrese un correo electronico valido';
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
                    /* _submit(); */
                  },
                  child: Row(
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
                      const SimpleText(
                        top: 20,
                        bottom: 20,
                        text: 'Envia email de recuperación',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* void _submit() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    /* print(this.emailField); */
    final resp = await this.mailServices.forgotPassword(this.emailField);
    if (resp) {
      showSnackBarNotification(
          context: context,
          message: 'Correo enviado, revise su bandeja de entrada',
          color: Colors.green);
      Navigator.pop(context);
    } else {
      showSnackBarNotification(
          context: context,
          message: 'Hubo un error al comprobar su email',
          color: Colors.red);
    }
  } */
}
