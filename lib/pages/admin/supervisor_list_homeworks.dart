part of '../pages.dart';

class SupervisorListHomeworks extends StatelessWidget {
  const SupervisorListHomeworks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final superviseServices = SuperviseServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(appBar: AppBar()),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: superviseServices.getHomeworksToSupervise(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay tareas'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HomeworkToSuperviseCard(
                        userName: "SOLO",
                        createdAt: snapshot.data[index].createdAt,
                        title: snapshot.data[index].title,
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
