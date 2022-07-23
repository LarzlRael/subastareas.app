part of '../../pages.dart';

class PendingOferedPendingHomework extends StatelessWidget {
  final HomeworkServices homeworkServices;

  const PendingOferedPendingHomework({Key? key, required this.homeworkServices})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    /* final getOffers =
         homeworkServices.getHomeworksResolvedByUser('pending_to_trade'); */

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future:
              homeworkServices.getHomeworksResolvedByUser('pending_to_accept'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final tradeUserModel = snapshot.data[index];
                  return HomeworkPendingToResolve(
                    tradeUserModel: tradeUserModel,
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
