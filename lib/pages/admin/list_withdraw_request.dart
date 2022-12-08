part of '../pages.dart';

class ListWithdrawRequest extends StatelessWidget {
  const ListWithdrawRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionService = TransactionServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Solicitudes de retiro',
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: transactionService.getListUserWithdrawRequest(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: SquareLoading());
                  }
                  if (snapshot.data!.isEmpty) {
                    return const NoInformation(
                      message: 'No hay solicitudes de retiro',
                      icon: FontAwesomeIcons.moneyBill,
                      showButton: false,
                      iconButton: Icons.add,
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return WithdrawRequestCard(
                        withdrawRequest: snapshot.data[index],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
