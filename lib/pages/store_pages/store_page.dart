part of '../pages.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                text: 'ADQUIERE MONEDAS PARA SUBASTAREAS',
                fontSize: 30,
                bottom: 30,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                color: Colors.black87,
              ),
              SimpleText(
                text: '-> Podras recompensar la ayuda de tus compañeros.',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                bottom: 5,
              ),
              SimpleText(
                text:
                    '-> Puedes asignar un monto para motivar la resolucion de una tarea',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
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
