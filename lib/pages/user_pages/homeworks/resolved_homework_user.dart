part of '../../pages.dart';

class ResolvedHomeworkUser extends StatelessWidget {
  final TradeServices tradeServices;
  const ResolvedHomeworkUser({Key? key, required this.tradeServices})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: tradeServices.getHomeworksResolved('accepted'),
          builder: (BuildContext context,
              AsyncSnapshot<List<TradeUserModel>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const NoInformation(
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
          },
        ),
      ),
    );
  }
}
