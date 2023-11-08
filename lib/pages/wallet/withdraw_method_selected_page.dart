part of '../pages.dart';

class WithdrawMethodSelectedPage extends StatefulWidget {
  final MethodArguments arguments;
  const WithdrawMethodSelectedPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<WithdrawMethodSelectedPage> createState() =>
      _WithdrawMethodSelectedPageState();
}

class _WithdrawMethodSelectedPageState
    extends State<WithdrawMethodSelectedPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
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
                  text:
                      'Retirar saldo por ${widget.arguments.methodName.toUpperCase()}',
                  fontSize: 18,
                  bottom: 15,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Hero(
                  tag: widget.arguments.methodName,
                  child: widget.arguments.logoWidget,
                ),
                const SizedBox(height: 20),
                RetirableInformation(user: user),
                FormBuilder(
                  initialValue: {
                    'balanceToWithDrawable': "0",
                    'phoneNumber': user.phone ?? "",
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
                            placeholder: 'Saldo a retirar ',
                            keyboardType: TextInputType.number,
                            suffixIcon: FontAwesomeIcons.coins,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.max(
                                  user.wallet.balanceWithDrawable),
                              FormBuilderValidators.min(1),
                            ]),
                          ),
                          CustomRowFormBuilderTextField(
                            name: 'phoneNumber',
                            placeholder: 'Número de teléfono',
                            keyboardType: TextInputType.number,
                            suffixIcon: FontAwesomeIcons.whatsapp,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                            ]),
                          ),
                        ],
                      ),
                      !_loading
                          ? FillButton(
                              label: "Retirar",
                              borderRadius: 50,
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _loading = true;
                                });

                                if (_formKey.currentState!.validate()) {}
                                _formKey.currentState!.save();
                                final amount = int.parse(_formKey.currentState!
                                    .value['balanceToWithDrawable']);
                                final phoneNumber =
                                    _formKey.currentState!.value['phoneNumber'];

                                transactionServices
                                    .withdrawMoneyTransaction(
                                  amount,
                                  phoneNumber,
                                )
                                    .then((resOk) {
                                  setState(() {
                                    _loading = false;
                                  });
                                  if (resOk) {
                                    context.push(
                                      '/my_homeworks_page',
                                      extra: 1,
                                    );
                                    _formKey.currentState!.reset();

                                    GlobalSnackBar.show(
                                        context, 'Tarea subida correctamente',
                                        backgroundColor: Colors.green);
                                  } else {
                                    GlobalSnackBar.show(
                                        context, 'Error al retirar puntos',
                                        backgroundColor: Colors.red);
                                  }
                                });
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
                        /* 'El pago se realizará en unos minutos, a partir de la hora de la solicitud de retiro, el procedimiento podria tardar hasta 72 horas', */
                        'Unos de nuestros asesores se pondrá en contacto contigo para realizar el pago',
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
