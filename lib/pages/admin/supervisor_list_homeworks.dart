part of '../pages.dart';

class SupervisorListHomeworks extends StatelessWidget {
  const SupervisorListHomeworks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final superviseServices = SuperviseServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(appBar: AppBar()),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: superviseServices.getHomeworksToSupervise(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: SquareLoading());
                  }
                  if (snapshot.data!.isEmpty) {
                    return const NoInformation(
                      message: 'Aún no hay tareas para revisar ',
                      icon: FontAwesomeIcons.book,
                      showButton: false,
                      iconButton: Icons.add,
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HomeworkToSuperviseCard(
                        homeworkToSupervise: snapshot.data[index],
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
