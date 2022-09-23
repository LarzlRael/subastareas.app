part of '../pages.dart';

class VerifyHomeworkResolved extends StatefulWidget {
  const VerifyHomeworkResolved({Key? key}) : super(key: key);

  @override
  State<VerifyHomeworkResolved> createState() => _VerifyHomeworkResolvedState();
}

class _VerifyHomeworkResolvedState extends State<VerifyHomeworkResolved> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final tradeUserModel =
        ModalRoute.of(context)!.settings.arguments as TradeUserModel;
    final tradeServices = TradeServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleText(
                  text: tradeUserModel.title,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                //No mostrar se creara un widget reutilizable para mostrar el estado de la tarea
                /* SimpleText(
                  text: tradeUserModel.resolutionTime.toString(),
                ), */
                tradeUserModel.solvedHomeworkUrl != null
                    ? FillButton(
                        text: 'Ver tarea resuelta',
                        backgroundColor: Colors.green,
                        borderRadius: 30,
                        textColor: Colors.white,
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
                tradeUserModel.status == 'accepted'
                    ? Container()
                    : !loading
                        ? Row(
                            children: [
                              Expanded(
                                child: FillButton(
                                  borderRadius: 5,
                                  text: "Rechazar",
                                  ghostButton: true,
                                  onPressed: () async {
                                    await tradeServices.acceptOrDeclineTrade(
                                        tradeUserModel.offerId, false);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: FillButton(
                                  borderRadius: 5,
                                  text: "Aceptar",
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    final accepted = await tradeServices
                                        .acceptOrDeclineTrade(
                                            tradeUserModel.offerId, true);
                                    setState(() {
                                      loading = false;
                                    });
                                    if (accepted) {
                                      Navigator.pop(context);
                                      GlobalSnackBar.show(context,
                                          "Tarea aceptada y confirmada",
                                          backgroundColor: Colors.green);
                                    } else {
                                      GlobalSnackBar.show(
                                          context, "Hubo un error",
                                          backgroundColor: Colors.red);
                                    }
                                  },
                                ),
                              )
                            ],
                          )
                        : const CircularProgressIndicator(),
                tradeUserModel.status == 'accepted'
                    ? const SimpleText(
                        text:
                            'Esta tarea ya fue resuelta y aceptada, puedes ver ahora',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
