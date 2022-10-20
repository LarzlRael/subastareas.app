part of '../pages.dart';

class MyOffers extends StatelessWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    final offerServices = OffersServices();
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Ionicons.paper_plane_outline),
                  text: "Ofertas realizadas",
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Ofertas recibidas",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder(
                future: offerServices.getUserOfferSent(),
                /* initialData: InitialData, */
                builder: (BuildContext context,
                    AsyncSnapshot<List<HomeworksModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const SquareLoading();
                  }
                  if (snapshot.data!.isEmpty) {
                    return NoInformation(
                      icon: Icons.assignment,
                      message: 'No tienes ofertas realizadas',
                      showButton: true,
                      iconButton: Icons.note_add,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, 'upload_homework_with_file');
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
                        goTo: 'auctionPage',
                        /* homework: snapshot.data[index], */
                      );
                    },
                  );
                },
              ),
              const Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
