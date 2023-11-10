part of '../pages.dart';

class PendingHomeworksOffersAccepts extends StatefulWidget {
  const PendingHomeworksOffersAccepts({Key? key}) : super(key: key);

  @override
  State<PendingHomeworksOffersAccepts> createState() =>
      _PendingHomeworksOffersAcceptsState();
}

class _PendingHomeworksOffersAcceptsState
    extends State<PendingHomeworksOffersAccepts> {
  late HomeworksProvider homeworksProvider;

  @override
  initState() {
    super.initState();
    homeworksProvider = context.read<HomeworksProvider>()
      ..getUserPendingsHomeworksToResolve();
  }

  @override
  Widget build(BuildContext context) {
    final offerServices = OffersServices();

    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Tareas pendientes',
      ),
      body: Consumer<HomeworksProvider>(
        builder: (_, oneHomeworkProviderC, child) {
          final pendingsHomeworks = homeworksProvider.pendingsHomeworkState;
          return pendingsHomeworks.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : pendingsHomeworks.pendingsHomeworks.isEmpty
                  ? const NoInformation(
                      message: 'No tienes ninguna tarea pendiente',
                      showButton: false,
                      icon: Icons.assignment_late,
                      iconButton: Icons.arrow_back,
                    )
                  : ListView.builder(
                      itemCount: pendingsHomeworks.pendingsHomeworks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeworkCard(
                          isLogged: true,
                          homework: pendingsHomeworks.pendingsHomeworks[index],
                          onSelected: (homework) {
                            context.push(
                              '/upload_homework_offered_page',
                              extra: HomeworkArguments(
                                homework.id,
                                homework.user.id,
                              ),
                            );
                          },
                        );
                      },
                    );
        },
      ),
    );
  }
}
