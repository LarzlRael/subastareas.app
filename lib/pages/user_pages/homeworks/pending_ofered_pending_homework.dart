part of '../../pages.dart';

class PendingOfferedPendingHomework extends StatelessWidget {
  final TradeServices tradeServices;

  const PendingOfferedPendingHomework({Key? key, required this.tradeServices})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: tradeServices.getHomeworksResolved('pending_to_accept'),
          builder: (BuildContext context,
              AsyncSnapshot<List<TradeUserModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const NoInformation(
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
