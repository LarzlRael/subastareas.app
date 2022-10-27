part of '../pages.dart';

class MyOffers extends StatelessWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offerServices = OffersServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Ionicons.send),
                  text: "Ofertas realizadas",
                ),
                Tab(
                  icon: Icon(Icons.call_received),
                  text: "Ofertas recibidas",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              OffersSent(offerServices: offerServices),
              OffersReceived(offerServices: offerServices),
            ],
          ),
        ),
      ),
    );
  }
}

class OffersSent extends StatelessWidget {
  const OffersSent({
    Key? key,
    required this.offerServices,
  }) : super(key: key);

  final OffersServices offerServices;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: offerServices.getUserOfferSent(),
      /* initialData: InitialData, */
      builder:
          (BuildContext context, AsyncSnapshot<List<HomeworksModel>> snapshot) {
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
              Navigator.pushNamed(context, 'upload_homework_with_file');
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
            );
          },
        );
      },
    );
  }
}

class OffersReceived extends StatelessWidget {
  const OffersReceived({
    Key? key,
    required this.offerServices,
  }) : super(key: key);

  final OffersServices offerServices;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: offerServices.getUserOffersReceived(),
      /* initialData: InitialData, */
      builder:
          (BuildContext context, AsyncSnapshot<List<HomeworksModel>> snapshot) {
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
              Navigator.pushNamed(context, 'upload_homework_with_file');
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
            );
          },
        );
      },
    );
  }
}
