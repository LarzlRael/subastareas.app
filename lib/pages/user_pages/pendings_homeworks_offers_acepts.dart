part of '../pages.dart';

class PendingHomeworksOffersAccepts extends StatelessWidget {
  const PendingHomeworksOffersAccepts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offerServices = OffersServices();

    return Scaffold(
      body: FutureBuilder(
        future: offerServices.getUsersHomeworksPending(),
        builder: (BuildContext context,
            AsyncSnapshot<List<HomeworksModel>> snapshot) {
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
                return HomeworkCard(
                  isLogged: true,
                  homework: snapshot.data![index],
                  goTo: 'upload_homework_offered_page',
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
    );
  }
}
