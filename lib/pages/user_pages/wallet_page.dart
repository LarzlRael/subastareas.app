part of '../pages.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SimpleText(
                    text: 'BILLETERA',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    top: 30,
                    bottom: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.wallet,
                        size: 150,
                        color: Colors.black87,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SimpleText(
                            text: auth.usuario.wallet.balance.toString(),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          SimpleText(
                            text: 'Monedas',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWithIcon(
                        label: 'Depositar',
                        icon: Icons.arrow_upward,
                        onPressed: () {
                          Navigator.pushNamed(context, 'store_page');
                        },
                      ),
                      ButtonWithIcon(
                        label: 'Retirar',
                        onPressed: () {},
                        icon: Icons.arrow_downward,
                      ),
                    ],
                  ),
                  const SimpleText(
                    text: 'HISTORIAL',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    top: 20,
                    bottom: 20,
                  ),
                ],
              ),
            ),
            TransactionCard(),
            TransactionCard(),
            TransactionCard(),
            TransactionCard(),
          ],
        ),
      ),
    );
  }
}
