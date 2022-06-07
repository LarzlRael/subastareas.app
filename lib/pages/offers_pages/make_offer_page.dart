part of '../pages.dart';

class MakeOfferPage extends StatefulWidget {
  const MakeOfferPage({Key? key}) : super(key: key);

  @override
  State<MakeOfferPage> createState() => _MakeOfferPageState();
}

class _MakeOfferPageState extends State<MakeOfferPage> {
  TextEditingController textController = TextEditingController();
  bool editing = false;
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final argumets =
        ModalRoute.of(context)!.settings.arguments as OneHomeworkModel;
    /* textController.text = argumets.homework.offeredAmount.toString(); */
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
                75,
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
              DescriptionText(
                desc: argumets.homework.description,
                textAlign: TextAlign.center,
                despegable: false,
              ),
              /* TimerCounter(
                endTime: DateTime.now().millisecondsSinceEpoch + 2000 * 30,
              ), */
              const SimpleText(
                text: 'Precio',
                top: 15,
                bottom: 15,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      if (hasFocus) {
                        editing = true;
                      } else {
                        editing = false;
                      }
                    });
                  },
                  child: editing
                      ? TextField(
                          textAlign: TextAlign.center,
                          controller: textController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Escribe tu oferta',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        )
                      : TextOnTap(
                          text: SimpleText(
                            text: textController.text,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            setState(() {
                              editing = true;
                            });
                          },
                        ),
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
                    showDataAlert(textController, argumets.homework.id);
                  },
                  label: 'Hacer Oferta',
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

  showDataAlert(TextEditingController myController, int idHomework) {
    final offersServices = OffersServices();
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
            ),
            content: Container(
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
                          final offer = await offersServices.makeOffer(
                              idHomework, int.parse(myController.text));
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          // fixedSize: Size(250, 50),
                        ),
                        child: const Text(
                          "Ofertar",
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
        });
  }
}
