import 'package:flutter/material.dart';
import 'package:subastareaspp/widgets/widgets.dart';

class AuctionPage extends StatefulWidget {
  const AuctionPage({Key? key}) : super(key: key);

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 25,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const SimpleText(
          text: 'Mi tarea de Matematica',
          color: Colors.black,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _imageCategory(),
              _cardAuction(),
              _buttonMakeOffer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardAuction() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SimpleText(
            text: 'Afro Web',
            fontWeight: FontWeight.w500,
            bottom: 15,
            fontSize: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoContainer(
                  'Creador',
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      SimpleText(
                        text: 'Nick Cannon',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ],
                  )),
              _infoContainer(
                'Acaba en ',
                const SimpleText(
                  text: '28 : 32 :12',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                /*   TimerCounter(
                  endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 30,
                  testStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ), */
              ),
            ],
          ),
          const SimpleText(
            text: 'Descripción',
            top: 20,
            bottom: 10,
            color: Colors.black,
            fontSize: 18,
          ),
          DescriptionText(
            desc:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic 38883888f8f899d',
          ),
          TextButton(
            child: Text('Ver Tarea '),
            onPressed: () {
              Navigator.pushNamed(context, 'showHomework');
            },
          ),
          const CircleAvatarGroup(
            urlImages: [
              'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
              'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
              'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
              'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
              'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
              'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
              'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
            ],
          ),
          Comments(),
        ],
      ),
    );
  }

  Widget _imageCategory() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.35,
      width: size.width,
      child: Image.network(
        'https://octutor.org/media/posts/11/math.jpg',
        /* width: 280.0, */
      ),
    );
  }

  Widget _buttonMakeOffer() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      /* width: size.width,
      height: size.height, */
      bottom: 0,
      child: Container(
        width: size.width * 1,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          /* crossAxisAlignment: CrossAxisAlignment.stretch, */
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SimpleText(
                  text: 'Ofertar',
                  fontSize: 15,
                  color: Colors.white,
                ),
                const SimpleText(
                  text: '8.52 ETH',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'makeOffer');
              },
              child: Text('Hacer una oferta'),
            ),
          ],
        ),
      ),
    );
  }

  _infoContainer(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: title,
          fontSize: 16,
          color: Colors.grey,
          bottom: 10,
        ),
        content,
      ],
    );
  }
}
