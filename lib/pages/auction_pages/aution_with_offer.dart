part of '../pages.dart';

class AutionWithOffer extends StatefulWidget {
  const AutionWithOffer({Key? key}) : super(key: key);

  @override
  State<AutionWithOffer> createState() => _AutionWithOfferState();
}

class _AutionWithOfferState extends State<AutionWithOffer> {
  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                  'https://concepto.de/wp-content/uploads/2018/08/f%C3%ADsica-e1534938838719.jpg'),
              _buttonOffer(size, auth.isLogged),
              Positioned(
                bottom: 30,
                child: Container(
                  width: size.width,
                  height: 100,
                  child: const Align(
                    child: FloatMenu(),
                  ),
                ),
                top: 0,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const SimpleText(
              text: "Ofertas de los vendedores",
              fontSize: 20,
              top: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              /* scrollDirection: Axis.horizontal, */
              itemCount: 10,
              itemBuilder: (context, index) {
                return PersonOfferHorizontal(
                  nameOffered: "Juan Perez",
                  offerPrice: 100,
                  active: index % 2 == 0,
                );
              },
            ),
          ),
          /* SizedBox(
            height: size.height * 0.20,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return PersonOfferHorizontal(
                  nameOffered: "Juan Perez",
                  offerPrice: 100,
                  active: index % 2 == 0,
                );
              },
            ),
          ), */
        ],
      ),
    );
  }

  Widget _buttonOffer(Size size, bool isLogged) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 170.0,
            ),
          ),
          Container(
            width: size.width * 0.75,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    0.0,
                    1.0,
                  ),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SimpleText(
                            text: 'Afro Weed',
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          /* TimerCounter(
                            endTime: DateTime.now().millisecondsSinceEpoch +
                                1000 * 30,
                          ) */
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigatorProtected(context, isLogged, 'makeOffer');
                        },
                        child: const SimpleText(
                          fontSize: 15,
                          text: "Hacer una oferta",
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
