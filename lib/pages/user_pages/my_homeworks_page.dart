part of '../pages.dart';

class MyHomeworksPage extends StatelessWidget {
  const MyHomeworksPage({Key? key, this.goToPage = 0}) : super(key: key);
  final int goToPage;
  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    final tradeServices = TradeServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      body: DefaultTabController(
        initialIndex: goToPage,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Ionicons.paper_plane_outline),
                  text: "Tareas subidas",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Tareas Pendientes",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Tareas resueltas",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UploadedHomeworkUser(homeworkServices: homeworkServices),
              PendingOfferedPendingHomework(tradeServices: tradeServices),
              ResolvedHomeworkUser(tradeServices: tradeServices),
            ],
          ),
        ),
      ),
    );
  }
}
