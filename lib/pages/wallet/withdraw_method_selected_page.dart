part of '../pages.dart';

class WithdrawMethodSelectedPage extends StatefulWidget {
  const WithdrawMethodSelectedPage({Key? key}) : super(key: key);

  @override
  State<WithdrawMethodSelectedPage> createState() =>
      _WithdrawMethodSelectedPageState();
}

class _WithdrawMethodSelectedPageState
    extends State<WithdrawMethodSelectedPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthServices>(context, listen: false).user;
    final args = ModalRoute.of(context)!.settings.arguments as MethodArguments;
    final transactionServices = TransactionServices();

    final _formKey = GlobalKey<FormBuilderState>();
    bool _loading = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo total'),
        actions: [
          Center(
            child: SimpleText(
              text: "${user.wallet.balanceTotal}",
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
                FormBuilder(
                  initialValue: const {
                    'balanceToWithDrawable': "0",
                  },
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CustomRowFormBuilderTextField(
                            name: 'balanceToWithDrawable',
                            placeholder: 'Presupuesto ',
                            keyboardType: TextInputType.number,
                            suffixIcon: FontAwesomeIcons.coins,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.max(
                                  user.wallet.balanceWithDrawable),
                              FormBuilderValidators.min(1),
                            ]),
                          ),
                        ],
                      ),
                      !_loading
                          ? FillButton(
                              label: "Retirar",
                              borderRadius: 50,
                              textColor: Colors.white,
                              onPressed: () async {
                                setState(() {
                                  _loading = true;
                                });
                                final validationSuccess =
                                    _formKey.currentState!.validate();

                                if (validationSuccess) {
                                  _formKey.currentState!.save();

                                  setState(() {
                                    _loading = true;
                                  });
                                  print(_formKey.currentState!
                                      .value['balanceToWithDrawable']);
                                  final withdrawMoneyTransaction =
                                      await transactionServices
                                          .withdrawMoneyTransaction(int.parse(
                                              _formKey.currentState!.value[
                                                  'balanceToWithDrawable']));
                                  if (withdrawMoneyTransaction) {
                                    Navigator.pushNamed(
                                        context, 'my_homeworks_page');
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _loading = false;
                                    });
                                    GlobalSnackBar.show(
                                        context, 'Tarea subida correctamente',
                                        backgroundColor: Colors.green);
                                  } else {
                                    setState(() {
                                      _loading = false;
                                    });
                                    GlobalSnackBar.show(
                                        context, 'Error al subir tarea',
                                        backgroundColor: Colors.red);
                                  }
                                }
                              },
                            )
                          : const Center(child: CircularProgressIndicator())
                    ],
                  ),
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
