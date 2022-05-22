part of 'pages.dart';

class MakeOfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleText(
                    text: '\$',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SimpleText(
                    text: '10',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ],
              ),
              SizedBox(
                /* width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 16)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const SimpleText(
                    text: 'Enviar oferta',
                    color: Colors.white,
                    fontSize: 17,
                  ), */
                width: double.infinity,
                child: ButtonWithIcon(
                  label: 'Enviar oferta',
                  icon: Icons.money_rounded,
                  onPressed: () {},
                  backgroundColorButton: Colors.blue,
                  verticalPadding: 14,
                  styleLabelButton: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  iconSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
