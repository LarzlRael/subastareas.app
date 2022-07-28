part of '../widgets.dart';

class StoreCard extends StatelessWidget {
  final double height = 120;
  final PlanesModel planesModel;

  const StoreCard({
    Key? key,
    required this.planesModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: <Widget>[
          // The containers in the background
          Column(
            children: <Widget>[
              Container(
                width: size.width,
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                /* color: Colors.blue, */
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    /* color: Colors.blue, */
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    ),
                  ),
                  width: double.infinity,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.currency_lira_outlined,
                        size: 70,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SimpleText(
                            text:
                                '${planesModel.amount} ${planesModel.amount == 1 ? 'moneda' : 'monedas'}',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            bottom: 10,
                          ),
                          SimpleText(
                            text: '${planesModel.price} USD',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            bottom: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              /* Container(
                height: MediaQuery.of(context).size.height * .10,
                color: Colors.green,
              ) */
            ],
          ),

          Container(
            alignment: Alignment.topCenter,
            padding:
                EdgeInsets.only(top: height * 0.75, right: 20.0, left: 150.0),
            child: SizedBox(
              height: 50.0,
              width: 150,
              child: Ink(
                /* color: Colors.yellow, */
                child: InkWell(
                  onTap: () {
                    print(planesModel.amount);
                  },
                  child: Card(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    elevation: 10.0,
                    child: const Center(
                      child: SimpleText(
                        text: 'Comprar',
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/* class StoreCard2 extends StatelessWidget {
  final double height = 150;
  final double amount;
  final double price;

  const StoreCard2({
    Key? key,
    required this.amount,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      /* color: Colors.yellow, */
      width: size.width,
      height: height,
      child: Stack(
        children: <Widget>[
          // The containers in the background
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 0.9 * size.width,
                height: height * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.currency_bitcoin,
                      size: 70,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SimpleText(
                          text: '$amount ${amount > 1 ? 'moneda' : 'monedas'}',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          bottom: 10,
                        ),
                        SimpleText(
                          text: '$price bolivianos',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          bottom: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                right: 75,
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    /* color: Colors.black, */
                  ),
                  child: Card(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    elevation: 10.0,
                    child: const Center(
                      child: SimpleText(
                        text: 'Comprar',
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 */