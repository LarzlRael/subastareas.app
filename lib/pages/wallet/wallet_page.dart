part of '../pages.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context);
    final transactionServices = TransactionServices();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          /* padding: const EdgeInsets.symmetric(horizontal: 20), */
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SimpleText(
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
                        const Icon(
                          Ionicons.wallet,
                          size: 150,
                          color: Colors.black87,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SimpleText(
                              text: auth.user.wallet.balance.toString(),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            const SimpleText(
                              text: 'Monedas',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ButtonWithIcon(
                            label: 'Adquirir monedas',
                            icon: Icons.arrow_upward,
                            onPressed: () {
                              Navigator.pushNamed(context, 'store_page');
                            },
                          ),
                        ),
                        Expanded(
                          child: ButtonWithIcon(
                            label: 'Retirar',
                            onPressed: () {
                              if (auth.user.wallet.balance > 0) {
                                Navigator.pushNamed(context, 'withdraw_page');
                              } else {
                                GlobalSnackBar.show(
                                    context, 'Tienes 0 de monedas',
                                    backgroundColor: Colors.red);
                              }
                            },
                            icon: Icons.arrow_downward,
                          ),
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
              FutureBuilder(
                future: transactionServices.getUserHistoryTransaction(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserTransactionModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No hay transacciones'),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransactionCard(
                            transaction: snapshot.data![index],
                          );
                        },
                      ),
                    );
                  } else {
                    return const CircularCenter();
                  }
                },
              ),
/*               const TransactionCard(),
              const TransactionCard(),
              const TransactionCard(),
              const TransactionCard(), */
            ],
          ),
        ),
      ),
    );
  }
}
