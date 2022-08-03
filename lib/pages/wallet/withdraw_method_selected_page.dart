part of '../pages.dart';

class WithdrawMethodSelectedPage extends StatelessWidget {
  const WithdrawMethodSelectedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthServices>(context, listen: false).user;
    final args = ModalRoute.of(context)!.settings.arguments as MethodArguments;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo'),
        actions: [
          Center(
            child: SimpleText(
              text: user.wallet.balance.toString(),
              right: 10,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleText(
                  text: 'Retirar saldo por ${args.methodName.toUpperCase()}',
                  fontSize: 18,
                  bottom: 15,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Hero(
                  tag: args.methodName,
                  child: args.logoWidget,
                ),
                const SizedBox(height: 20),
                RetirableInformation(user: user),
                Form(
                  key: formKey,
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    /* initialValue: 0, */
                    decoration: InputDecoration(
                        labelText:
                            'Retirar cantidad 0 - ${user.wallet.balance}'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es requerido, para poder retirar';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => print(value),
                  ),
                ),
                FillButton(
                  borderRadius: 1,
                  text: "Retirar",
                  onPressed: () async {},
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SimpleText(
                    text:
                        'El pago se realizará en unos minutos, a partir de la hora de la solicitud de retiro, el procedimiento podria tardar hasta 72 horas',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
