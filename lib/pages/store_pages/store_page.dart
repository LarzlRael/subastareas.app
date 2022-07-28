part of '../pages.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tradeServices = TradeServices();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SimpleText(
                  text: 'ADQUIERE MONEDAS PARA SUBASTAREAS',
                  fontSize: 25,
                  bottom: 30,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: Colors.black87,
                ),
                const SimpleText(
                  text: '-> Podras recompensar la ayuda de tus compañeros.',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  bottom: 5,
                ),
                const SimpleText(
                  text:
                      '-> Puedes asignar un monto para motivar la resolucion de una tarea.',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: tradeServices.getPlanes(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PlanesModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StoreCard(
                            planesModel: snapshot.data![index],
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
