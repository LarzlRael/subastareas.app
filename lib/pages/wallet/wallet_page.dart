part of '../pages.dart';

class WalletPage extends StatelessWidget {
  WalletPage({Key? key}) : super(key: key);
  late final AuthServices auth;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthServices>(context);
    final theme = Provider.of<ThemeChanger>(context);
    final transactionServices = TransactionServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      backgroundColor: theme.isDarkTheme
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.grey[300],
      body: SafeArea(
        child: Container(
          color: theme.isDarkTheme
              ? Theme.of(context).scaffoldBackgroundColor
              : Colors.grey[300],
          /* padding: const EdgeInsets.symmetric(horizontal: 20), */
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: theme.isDarkTheme
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SimpleText(
                      text: 'BILLETERA',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      lightThemeColor: Colors.black87,
                      /* top: 10, */
                      bottom: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Ionicons.wallet,
                          size: 150,
                          /* color: Colors.black87, */
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            showWalletInfo(
                              auth.user.wallet.balanceTotal,
                              'Saldo Total',
                            ),
                            showWalletInfo(
                              auth.user.wallet.balanceWithDrawable,
                              'Saldo Retirable',
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
                              if (auth.user.wallet.balanceWithDrawable > 0) {
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
              Expanded(
                child: FutureBuilder(
                  future: transactionServices.getUserHistoryTransaction(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserTransactionModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularCenter();
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: NoInformation(
                          icon: Icons.hourglass_empty,
                          message: 'No tienes transacciones',
                          showButton: false,
                          iconButton: Icons.arrow_forward_ios,
                        ),
                      );
                    }
                    return SmartRefresher(
                      onRefresh: _refreshUser,
                      controller: _refreshController,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransactionCard(
                            transaction: snapshot.data![index],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showWalletInfo(int amount, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          SimpleText(
            text: title,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          SimpleText(
            text: "$amount",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  void _refreshUser() async {
    await auth.refreshUser();
    _refreshController.refreshCompleted();
  }
}
