part of '../../pages.dart';

class PendingOferedPendingHomework extends StatelessWidget {
  final TradeServices tradeServices;

  const PendingOferedPendingHomework({Key? key, required this.tradeServices})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    /* final getOffers =
         homeworkServices.getHomeworksResolvedByUser('pending_to_trade'); */

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: tradeServices.getHomeworksResolvedByUser('pending_to_accept'),
          builder: (BuildContext context,
              AsyncSnapshot<List<TradeUserModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return NoInformation(
                  message: 'No tienes ninguna tarea pendiente',
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
      ),
    );
  }
}
