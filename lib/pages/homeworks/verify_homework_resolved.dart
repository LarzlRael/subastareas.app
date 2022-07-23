part of '../pages.dart';

class VerifyHomeworkResolved extends StatelessWidget {
  const VerifyHomeworkResolved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tradeUserModel =
        ModalRoute.of(context)!.settings.arguments as TradeUserModel;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleText(
                  text: tradeUserModel.title,
                ),
                SimpleText(
                  text: tradeUserModel.resolutionTime.toString(),
                ),
                tradeUserModel.solvedHomeworkUrl != null
                    ? LoginButton(
                        text: "Ver tarea resuelta",
                        textColor: Colors.white,
                        showIcon: false,
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            'showHomework',
                            arguments: tradeUserModel.solvedHomeworkUrl,
                          );
                        },
                      )
                    : Container(),
                tradeUserModel.description != null
                    ? SimpleText(
                        text: tradeUserModel.description!,
                      )
                    : Container(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
