import 'package:flutter/material.dart';
import 'package:subastareaspp/widgets/widgets.dart';

class MakeOfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
              ),
              SimpleText(
                top: 15,
                bottom: 15,
                text: 'Andrea Parada',
                /* color: Colors.grey, */
              ),
              DescriptionText(
                desc:
                    'esta es la tarea a demas de todos lo demas qeue teihufhs cuando no todo sennerne',
                textAlign: TextAlign.center,
              ),
              /* TimerCounter(
                endTime: DateTime.now().millisecondsSinceEpoch + 2000 * 30,
              ), */
              SimpleText(text: 'Tu oferta', top: 15, bottom: 15),
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
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text('Enviar oferta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
