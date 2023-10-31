part of '../../pages.dart';

class UploadedHomeworkUser extends StatelessWidget {
  final HomeworkServices homeworkServices;

  const UploadedHomeworkUser({
    Key? key,
    required this.homeworkServices,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeworkServices.getHomeworksByUser(),
      /* initialData: InitialData, */
      builder:
          (BuildContext context, AsyncSnapshot<List<HomeworksModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.isEmpty) {
          return NoInformation(
            icon: Icons.assignment,
            message: 'No tienes ofertas realizadas',
            showButton: true,
            iconButton: Icons.note_add,
            onPressed: () {
              context.push('home_page');
            },
            buttonTitle: 'Subir tarea',
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
              onSelected: (homework) {
                context.push(
                  '/homework_detail/${homework.id}',
                );
              },
              /* homework: snapshot.data[index], */
            );
          },
        );
      },
    );
  }
}
