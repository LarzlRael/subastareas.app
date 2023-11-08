part of '../pages.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context);

    changePassword() {
      final validationSuccess = _formKey.currentState!.validate();

      if (!validationSuccess) return;

      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      final formKey = _formKey.currentState!;
      authService
          .changePassword(
        formKey.value['password'],
        formKey.value['confirmPassword'],
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value) {
          context.pop();
          GlobalSnackBar.show(
            context,
            'Contraseña cambiada correctamente',
            backgroundColor: Colors.green,
          );
        } else {
          GlobalSnackBar.show(
            context,
            'Error al cambiar contraseña',
            backgroundColor: Colors.red,
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(
          title: const SimpleText(
            text: 'Change Password',
            darkThemeColor: Colors.black,
            lightThemeColor: Colors.white,
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SimpleText(
              text: 'CAMBIAR CONTRASEÑA',
              textAlign: TextAlign.center,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              bottom: 10,
            ),
            const SizedBox(
              child: Icon(
                Icons.lock,
                size: 200,
              ),
            ),
            const SimpleText(
              text: 'Tu nueva contraseña debe ser diferente a las anteriores',
              textAlign: TextAlign.center,
              fontSize: 14,
              top: 10,
              fontWeight: FontWeight.w500,
            ),
            // two inputs
            FormBuilder(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const CustomFormBuilderTextField(
                      name: 'password',
                      icon: FontAwesomeIcons.lock,
                      placeholder: 'Contraseña',
                      passwordField: true,
                    ),
                    const CustomFormBuilderTextField(
                      name: 'confirmPassword',
                      icon: FontAwesomeIcons.lock,
                      placeholder: 'Confirmar Contraseña',
                      passwordField: true,
                    ),
                    FillButton(
                        label: "Cambiar contraseña",
                        textColor: Colors.white,
                        borderRadius: 50,
                        onPressed: changePassword),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
