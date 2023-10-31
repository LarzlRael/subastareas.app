part of '../pages.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthServices>(context, listen: false).user;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 20) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo'),
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            balanceInformation(user),
            const SimpleText(
              text: 'Seleccione un metodo de retiro',
              fontSize: 20,
              top: 55,
              fontWeight: FontWeight.w500,
            ),
            /* Expanded(
              child: GridView.count(
                childAspectRatio: (itemWidth / itemHeight),
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  CardMethodSelect(
                    arguments: MethodArguments(
                        methodName: 'Tigo money',
                        logoWidget: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xff00377B),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.asset(
                            'assets/payment_logos/tigo_money_logo.png',
                            width: 200,
                            height: 75,
                          ),
                        ),
                        imageLocation:
                            'assets/payment_logos/tigo_money_logo.png'),
                  ),
                  CardMethodSelect(
                    arguments: MethodArguments(
                      methodName: 'Transferencia bancaria',
                      logoWidget: Image.asset(
                        'assets/payment_logos/mercantilSC.png',
                        width: 200,
                        height: 75,
                      ),
                      imageLocation: 'assets/payment_logos/mercantilSC.png',
                    ),
                  ),
                ],
              ),
            ) */
            CardMethodSelect(
              arguments: MethodArguments(
                  methodName: 'Tigo money',
                  logoWidget: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xff00377B),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset(
                      'assets/payment_logos/tigo_money_logo.png',
                      width: 200,
                      height: 75,
                    ),
                  ),
                  imageLocation: 'assets/payment_logos/tigo_money_logo.png'),
            ),
          ],
        ),
      ),
    );
  }

  Row balanceInformation(UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RetirableInformation(user: user),
        const InformationWalletStatus(
          icon: Icons.check_circle,
          title: 'Control de identidad',
        ),
        /* const InformationWalletStatus(
          icon: Icons.check_circle,
          title: 'Control de identidad',
        ), */
        /*  const InformationWalletStatus(
          icon: Icons.check_rounded,
          title: 'Verificacion de dirección',
        ), */
      ],
    );
  }
}

class RetirableInformation extends StatelessWidget {
  final UserModel user;
  const RetirableInformation({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SimpleText(
              //TODO : find a better way to name this
              text: 'Saldo para retiro',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(width: 2),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.help, color: Colors.grey),
              tooltip:
                  'Puedes retirar fondos que solo hayan sido a traves de la resolucion de tareas en Subastareas',
              onPressed: () {},
            ),
          ],
        ),
        SimpleText(
          text: "${user.wallet.balanceWithDrawable}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MethodArguments {
  final String methodName;
  final Widget logoWidget;
  final String imageLocation;
  const MethodArguments({
    required this.methodName,
    required this.logoWidget,
    required this.imageLocation,
  });
}

class CardMethodSelect extends StatelessWidget {
  final MethodArguments arguments;
  const CardMethodSelect({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('withdraw_method_selected_page', extra: arguments);
      },
      child: Hero(
        tag: arguments.methodName,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                arguments.logoWidget,
                const SizedBox(height: 2),
                SimpleText(
                  text: arguments.methodName,
                  textAlign: TextAlign.center,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                /* SimpleText(
                    text: '2.5% Tarifa + 1.26',
                  ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InformationWalletStatus extends StatelessWidget {
  final IconData icon;
  final String title;
  const InformationWalletStatus({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        const SizedBox(
          width: 5,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SimpleText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          const SimpleText(
            text: 'APROBADO',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            lightThemeColor: Colors.green,
          ),
        ]),
      ],
    );
  }
}
