part of '../pages.dart';

class MakeOfferPage extends StatefulWidget {
  const MakeOfferPage({Key? key}) : super(key: key);

  @override
  State<MakeOfferPage> createState() => _MakeOfferPageState();
}

class _MakeOfferPageState extends State<MakeOfferPage> {
  TextEditingController textController = TextEditingController();
  bool editing = false;
  late SocketService socketService;
  @override
  void initState() {
    socketService = Provider.of<SocketService>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final argumets =
        ModalRoute.of(context)!.settings.arguments as OneHomeworkModel;
    final auth = Provider.of<AuthServices>(context, listen: false);
    final verify =
        argumets.offers.map((item) => item.user.id).contains(auth.user.id);

    return Scaffold(
      appBar: AppBar(
        /* title: Text('Hacer oferta'), */
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              showProfileImage(
                argumets.homework.user.profileImageUrl,
                argumets.homework.user.username,
                radius: 75,
              ),
              SimpleText(
                top: 25,
                bottom: 25,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                text: argumets.homework.user.username,
                /* color: Colors.grey, */
              ),
              argumets.homework.description != null
                  ? DescriptionText(
                      desc: argumets.homework.description!,
                      textAlign: TextAlign.center,
                      despegable: false,
                    )
                  : Container(),
              /* TimerCounter(
                endTime: DateTime.now().millisecondsSinceEpoch + 2000 * 30,
              ), */

              verify
                  ? SimpleText(
                      text:
                          'Tu oferta es de ${argumets.offers.where((i) => i.user.id == auth.user.id).first.priceOffer}',
                      top: 15,
                      bottom: 15,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    )
                  : const SizedBox(
                      height: 10,
                    ),
              const SimpleText(
                text: 'Precio',
                top: 15,
                bottom: 15,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width * 0.7,
                child: SimpleText(
                  text: '${argumets.homework.offeredAmount}',
                  textAlign: TextAlign.center,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonWithIcon(
                  verticalPadding: 15,
                  onPressed: () {
                    showDataAlert(argumets.homework.id, verify,
                        amount: argumets.homework.offeredAmount,
                        //TODO corregir este bug
                        idOffer: /* argumets.offers
                                  .where((i) => i.user.id == auth.user.id)
                                  .first
                                  .id ==
                              null
                          ? 0
                          : argumets.offers
                              .where((i) => i.user.id == auth.user.id)
                              .first
                              .id ,*/
                            0);
                    /* Navigator.pop(context); */
                  },
                  label: verify ? 'Editar oferta' : 'Hacer oferta',
                  icon: Icons.send,
                  /* marginVertical: 10, */
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showDataAlert(
    int idHomework,
    bool verify, {
    int amount = 0,
    int idOffer = 0,
  }) {
    TextEditingController myController = TextEditingController();
    if (verify) {
      myController.text = amount.toString();
    }
    final blocHomework = OneHomeworkBloc();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title: const SimpleText(
            text: "Hacer oferta",
            fontSize: 24.0,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Ingrese cantidad ",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: myController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese su oferta',
                        labelText: 'Oferta',
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final newOffer = await blocHomework.makeOrEditOffer(
                          verify,
                          idHomework,
                          int.parse(myController.text),
                          idOffer,
                        );
                        //emitir evento para actualizar la lista de ofertas
                        socketService.emit('makeOfferToServer', {
                          'room': idHomework,
                          'offer': newOffer,
                        });
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        // fixedSize: Size(250, 50),
                      ),
                      child: Text(
                        !verify ? "Ofertar" : "Editar oferta",
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const SimpleText(text: 'Nota: '),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SimpleText(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
                          ' ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
