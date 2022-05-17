import 'package:flutter/material.dart';
import 'package:subastareaspp/widgets/widgets.dart';

class AutionWithOffer extends StatelessWidget {
  const AutionWithOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                  'https://concepto.de/wp-content/uploads/2018/08/f%C3%ADsica-e1534938838719.jpg'),
              _buttonOffer(size),
              Positioned(
                bottom: 30,
                child: Container(
                  width: size.width,
                  height: 100,
                  child: Align(
                    child: FloatMenu(),
                  ),
                ),
                top: 0,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: SimpleText(
              text: "Ofertas de los vendedores",
              fontSize: 20,
              top: 10,
              bottom: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return PersonOfferCard(
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

  Widget _buttonOffer(Size size) {
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
                          SimpleText(
                            text: 'Afro Weed',
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          SimpleText(
                            fontSize: 15,
                            top: 5,
                            text: '28 : 30 : 00',
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: SimpleText(
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
