part of '../../pages.dart';

class ResolvedHomeworkUser extends StatelessWidget {
  final TradeServices tradeServices;
  const ResolvedHomeworkUser({Key? key, required this.tradeServices})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final getOffers = tradeServices.getHomeworksResolvedByUser('accepted');
    /* print('getOffers: $getOffers'); */
    inspect(getOffers);
    return Scaffold(
      body: FutureBuilder(
        future: tradeServices.getHomeworksResolvedByUser('accepted'),
        builder: (BuildContext context,
            AsyncSnapshot<List<TradeUserModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return NoInformation(
                message: 'No tienes ninguna tarea resuelta',
                showButton: false,
                icon: Icons.assignment_late,
                iconButton: Icons.arrow_back,
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return HomeworkPendingToResolve(
                  tradeUserModel: snapshot.data![index],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
