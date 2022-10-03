part of '../pages.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tradeServices = TradeServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Tienda',
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SimpleText(
                text: 'ADQUIERE MONEDAS PARA SUBASTAREAS',
                fontSize: 25,
                bottom: 30,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                lightThemeColor: Colors.black87,
              ),
              const SimpleText(
                text: '\u2022 Podrás recompensar la ayuda de tus compañeros.',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                bottom: 5,
              ),
              const SimpleText(
                text:
                    '\u2022 Puedes asignar un monto para motivar la resolucion de una tarea.',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 5),
              FutureBuilder(
                future: tradeServices.getPlanes(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PlanesModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StoreCard(
                            planesModel: snapshot.data![index],
                          );
                        },
                      ),
                    );
                  } else {
                    return const CircularCenter();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
