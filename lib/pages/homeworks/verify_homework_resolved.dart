part of '../pages.dart';

class VerifyHomeworkResolved extends StatelessWidget {
  const VerifyHomeworkResolved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          SimpleText(
            text: 'Titulo de la tarea',
          ),
          SimpleText(
            text: 'Contador',
          ),
          LoginButton(
            text: "Ver tarea resuelta",
            textColor: Colors.white,
            showIcon: false,
            onPressed: () async {},
          ),
          SimpleText(
            text: 'Descripcion de la tarea si es que tiene',
          ),
          Row(
            children: [
              ButtonWithIcon(
                label: 'Aceptar',
                onPressed: () async {
                  /* await offersServices.acceptOffer(getIdOfferAcceptd); */
                },
              ),
              ButtonWithIcon(
                label: 'Rechazar',
                onPressed: () async {
                  /* await offersServices.acceptOffer(getIdOfferAcceptd); */
                },
              )
            ],
          ),
          SimpleText(
            text:
                'Recuerda que debes aceptar para terminar con la tarea, si no podrias ser renunciado',
          ),
        ]),
      ),
    );
  }
}
