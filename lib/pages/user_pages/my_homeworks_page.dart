part of '../pages.dart';

class MyHomeworksPage extends StatelessWidget {
  final int goToPage;
  const MyHomeworksPage({
    Key? key,
    this.goToPage = 0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeworkServices = context.read<HomeworksProvider>();
    final tradeServices = TradeServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Mis tareas',
      ),
      body: DefaultTabController(
        initialIndex: goToPage,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  icon: Icon(Ionicons.paper_plane_outline),
                  text: "Tareas subidas",
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.listCheck),
                  text: "Tareas por revisar",
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.circleCheck),
                  text: "Tareas resueltas por otros usuarios",
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.circleCheck),
                  text: "Tareas resueltas",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UploadedHomeworkUser(howeworkServices: homeworkServices),
              PendingOfferedPendingHomework(tradeServices: tradeServices),
              ResolvedHomeworkUser(tradeServices: tradeServices),
              ResolvedHomeworkUser(tradeServices: tradeServices),
            ],
          ),
        ),
      ),
    );
  }
}
