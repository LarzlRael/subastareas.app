part of '../pages.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SimpleText(
                text: 'ADQUIERE MONEDAS PARA SUBASTAREAS',
                fontSize: 25,
                bottom: 30,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                color: Colors.black87,
              ),
              SimpleText(
                text: '-> Podras recompensar la ayuda de tus compañeros.',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                bottom: 5,
              ),
              SimpleText(
                text:
                    '-> Puedes asignar un monto para motivar la resolucion de una tarea.',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10),
              //todo consulta a la base de datos
              StoreCard(amount: 1, price: 4.87),
              StoreCard(amount: 1, price: 4.87),
              StoreCard(amount: 1, price: 4.87),
            ],
          ),
        ),
      ),
    );
  }
}
