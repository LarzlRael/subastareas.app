part of '../pages.dart';

class MyOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
