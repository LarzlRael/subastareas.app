part of '../pages.dart';

class VerifyHomeworkResolved extends StatelessWidget {
  const VerifyHomeworkResolved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tradeUserModel =
        ModalRoute.of(context)!.settings.arguments as TradeUserModel;
    final tradeServices = TradeServices();
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
                //No motrar se creara un widget reutilizable para mostrar el estado de la tarea
                /* SimpleText(
                  text: tradeUserModel.resolutionTime.toString(),
                ), */
                tradeUserModel.solvedHomeworkUrl != null
                    ? LoginButton(
                        text: "Ver tarea resuelta",
                        textColor: Colors.white,
                        backGroundColor: Colors.green,
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
                /* Row(
                  children: [
                    Expanded(
                      child: FillButton(
                        borderRadius: 5,
                        text: "Rechazar",
                        ghostButton: true,
                        onPressed: () async {
                          await tradeServices.acceptOrDeclineTrade(
                              tradeUserModel.id, tradeUserModel.tradeId, false);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FillButton(
                        borderRadius: 5,
                        text: "Aceptar",
                        onPressed: () async {
                          await tradeServices.acceptOrDeclineTrade(
                              tradeUserModel.tradeId, true);
                        },
                      ),
                    ),
                  ],
                ), */
                SimpleText(
                  textAlign: TextAlign.center,
                  text:
                      'Esta tarea ya fue resuelta y aceptada, puedes ver ahora mismo',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
