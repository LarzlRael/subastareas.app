part of '../pages.dart';

class AutionWithOfferPage extends StatefulWidget {
  const AutionWithOfferPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AutionWithOfferPage> createState() => _AutionWithOfferPageState();
}

class _AutionWithOfferPageState extends State<AutionWithOfferPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OneHomeworkModel;
    final auth = Provider.of<AuthServices>(context, listen: false);

    OneHomeworkBloc homeworksBloc = OneHomeworkBloc();
    homeworksBloc.getOneHomework(args.homework.id);
    final isOwner = auth.user.id == args.homework.user.id;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ImageBackgorundAndTimer(
                      auth: auth, homework: args, isOwner: isOwner),
                  const SimpleText(
                    text: "Ofertas de los vendedores",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    top: 15,
                    bottom: 15,
                  ),
                  StreamBuilder(
                    stream: homeworksBloc.oneHomeworkStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<OneHomeworkModel> snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.data!.offers.isEmpty) {
                        return NoInformation(
                          message: 'No hay ofertas aun',
                          icon: Icons.search_off,
                          showButton: false,
                          iconButton: Icons.add,
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            /* scrollDirection: Axis.horizontal, */
                            itemCount: snapshot.data!.offers.length,
                            itemBuilder: (context, index) {
                              return PersonOfferHorizontal(
                                offer: snapshot.data!.offers[index],
                                auth: auth,
                                homework: args,
                                isOwner: isOwner,
                                /* active: index % 2 == 0, */
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            /* filterProvider.getShowButtonAcept
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    child: AcceptOfferButton(
                      amount: args.homework.priceOffer.toString(),
                    ),
                  )
                : Container(), */
          ],
        ),
      ),
    );
  }
}

class AcceptOfferButton extends StatelessWidget {
  final Offer offer;
  const AcceptOfferButton({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offersServices = OffersServices();
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleText(
                text: 'Aceptar oferta',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              SimpleText(text: offer.priceOffer.toString()),
            ],
          ),
          MaterialButton(
            onPressed: () {
              offersServices.enterPendingTrade(offer.id);
              Navigator.of(context).pop();
            },
            height: 45,
            minWidth: 150,
            elevation: 0,
            shape: StadiumBorder(),
            color: Colors.black,
            child:
                SimpleText(text: 'Aceptar', color: Colors.white, fontSize: 22),
          ),
        ],
      ),
    );
  }
}

class _ButtonOffer extends StatelessWidget {
  final bool isLogged;
  final OneHomeworkModel homework;

  const _ButtonOffer({
    Key? key,
    required this.isLogged,
    required this.homework,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Container(
            width: size.width * 0.75,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                const BoxShadow(
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
                                getDateDiff(homework.homework.resolutionTime)
                                    .inMilliseconds,
                          ) */
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigatorProtected(
                            context,
                            isLogged,
                            'makeOffer',
                            homework,
                          );
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

/* Widget _buttonOffer(Size size, bool isLogged, OneHomeworkModel homework) {
    
  } */

class _ImageBackgorundAndTimer extends StatelessWidget {
  final AuthServices auth;
  final OneHomeworkModel homework;
  final bool isOwner;
  const _ImageBackgorundAndTimer(
      {Key? key,
      required this.auth,
      required this.homework,
      required this.isOwner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    /* return Stack(
      children: [
        Image.network(
            'https://concepto.de/wp-content/uploads/2018/08/f%C3%ADsica-e1534938838719.jpg'),
        _ButtonOffer(isLogged: auth.isLogged, homework: homework),
        Positioned(
          bottom: 30,
          child: SizedBox(
            width: size.width,
            height: 100,
            child: const Align(
              child: FloatMenu(),
            ),
          ),
          top: 0,
        ),
      ],
    ); */
    final double height = size.height * 0.35;
    return Stack(
      children: <Widget>[
        // The containers in the background
        Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              /* color: Colors.blue, */
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  /* color: Colors.blue, */
                ),
                width: double.infinity,
                height: 100,
                child: Image.network(
                    'https://concepto.de/wp-content/uploads/2018/08/f%C3%ADsica-e1534938838719.jpg',
                    fit: BoxFit.fill),
              ),
            ),
            /* Container(
                height: MediaQuery.of(context).size.height * .10,
                color: Colors.green,
              ) */
          ],
        ),
        !isOwner
            ? Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                  top: height * 0.75,
                ),
                child:
                    _ButtonOffer(isLogged: auth.isLogged, homework: homework),
              )
            : Container()
      ],
    );
  }
}
