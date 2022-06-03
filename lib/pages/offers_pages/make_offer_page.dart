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
  Widget build(BuildContext context) {
    textController.text = '100';
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
              const CircleAvatar(
                radius: 75,
              ),
              const SimpleText(
                top: 25,
                bottom: 25,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                text: 'Andrea Parada',
                /* color: Colors.grey, */
              ),
              const DescriptionText(
                desc:
                    'esta es la tarea a demas de todos lo demas qeue teihufhs cuando no todo sennerne ademas de todo esto no podemo snegar que fue lo que fue xd',
                textAlign: TextAlign.center,
                despegable: false,
              ),
              /* TimerCounter(
                endTime: DateTime.now().millisecondsSinceEpoch + 2000 * 30,
              ), */
              const SimpleText(
                text: 'Tu oferta',
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
                  onPressed: () {},
                  label: 'Enviar Oferta',
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
}
