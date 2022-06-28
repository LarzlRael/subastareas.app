part of '../pages.dart';

class MyHomeworksPage extends StatelessWidget {
  const MyHomeworksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    return Scaffold(
      body: FutureBuilder(
        future: homeworkServices.getHomeworksByUser(),
        /* initialData: InitialData, */
        builder: (BuildContext context,
            AsyncSnapshot<List<HomeworksModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return NoInformation(
                icon: Icons.assignment,
                message: 'No tienes tareas Subidas',
                showButton: true,
                iconButton: Icons.abc,
                onPressed: () {
                  Navigator.pushNamed(context, 'uploadHomework');
                },
                buttonTitle: 'Subir Tarea',
              );
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return HomeworkCard(
                  isLogged: true,
                  homework: snapshot.data![index],

                  /* homework: snapshot.data[index], */
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

  Widget showHomework(HomeworksModel homework) {
    switch (homework.fileType) {
      case 'only_text':
        return Text(homework.category);

      case 'application/pdf':
        return HomeworkCard(
          isLogged: true,
          homework: homework,

          /* homework: snapshot.data[index], */
        );
      default:
        return Text(homework.category);
    }
  }
}
