part of '../pages.dart';

class ShowHomeworkParams {
  String title;
  String fileType;
  String fileUrl;
  ShowHomeworkParams({
    required this.title,
    required this.fileType,
    required this.fileUrl,
  });
}

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
    final _formKey = GlobalKey<FormBuilderState>();
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
                tradeUserModel.status == 'rejected'
                    ? statusMessage("ESta tarea fue rechazada", Icons.error,
                        color: Colors.red)
                    : const SizedBox(),
                SimpleText(
                  text: tradeUserModel.title.toCapitalized(),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                //No mostrar se creara un widget reutilizable para mostrar el estado de la tarea
                /* SimpleText(
                  text: tradeUserModel.resolutionTime.toString(),
                ), */
                tradeUserModel.fileUrl != null
                    ? FillButton(
                        label: 'Ver tarea subida',
                        backgroundColor: Colors.blue,
                        borderRadius: 30,
                        textColor: Colors.white,
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            'show_homework_uploaded',
                            arguments: tradeUserModel.solvedHomeworkUrl,
                          );
                        },
                      )
                    : const SizedBox(),
                tradeUserModel.solvedHomeworkUrl != null
                    ? Column(
                        children: [
                          tradeUserModel.status == 'accepted'
                              ? Column(
                                  children: const [
                                    SimpleText(
                                      text:
                                          'Esta tarea ya fue resuelta y aceptada, puedes ver ahora',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          FillButton(
                            label: 'Ver tarea resuelta',
                            backgroundColor: Colors.green,
                            borderRadius: 30,
                            textColor: Colors.white,
                            onPressed: () async {
                              Navigator.pushNamed(
                                context,
                                'show_homework_uploaded',
                                arguments: ShowHomeworkParams(
                                  title: tradeUserModel.title,
                                  fileType: tradeUserModel.solvedFileType,
                                  fileUrl: tradeUserModel.solvedHomeworkUrl,
                                ),
                              );
                            },
                          ),
                          tradeUserModel.status != 'accepted'
                              ? FormBuilder(
                                  key: _formKey,
                                  child: Column(
                                    children: const [
                                      CustomFormBuilderTextField(
                                        name: 'commentTaskRejected',
                                        icon: FontAwesomeIcons.ban,
                                        placeholder:
                                            'Describe el motivo de rechazo',
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      )
                    : Container(),
                tradeUserModel.description != null
                    ? SimpleText(
                        text: tradeUserModel.description!,
                      )
                    : Container(),
                tradeUserModel.status == 'rejected'
                    ? Column(
                        children: [
                          SimpleText(
                            text: 'Motivo de rechazo',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          SimpleText(
                            text: tradeUserModel.commentTaskRejected!,
                          ),
                        ],
                      )
                    : const SizedBox(),
                tradeUserModel.status == 'accepted'
                    ? Container()
                    : !loading
                        ? Row(
                            children: [
                              Expanded(
                                child: FillButton(
                                  borderRadius: 5,
                                  label: "Rechazar",
                                  ghostButton: true,
                                  onPressed: () async {
                                    final result = await tradeServices
                                        .acceptOrDeclineTrade(
                                            tradeUserModel.offerId, false,
                                            reasonRejected: _formKey
                                                .currentState!
                                                .fields['commentTaskRejected']!
                                                .value);
                                    if (result) {
                                      Navigator.pushNamed(
                                        context,
                                        'my_homeworks_page',
                                        arguments: 1,
                                      );
                                      GlobalSnackBar.show(
                                        context,
                                        'Tarea rechazada',
                                        backgroundColor: Colors.red,
                                      );
                                    } else {
                                      GlobalSnackBar.show(
                                        context,
                                        'Hubo un error',
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: FillButton(
                                  borderRadius: 5,
                                  label: "Aceptar",
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
                                      /* Use bloc for this */
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
                    ? Column(
                        children: [
                          const SimpleText(
                            text: 'Esta tarea fue resuelta por:  ',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: () {
                              /* The id is from the id resolver user */
                              Navigator.pushNamed(
                                context,
                                'public_profile_page',
                                arguments: tradeUserModel.id,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ShowProfileImage(
                                  profileImage: tradeUserModel.profileImageUrl,
                                  userName: tradeUserModel.username,
                                  radius: 18),
                            ),
                          ),
                          SimpleText(
                            text: tradeUserModel.username.toCapitalized(),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            setUniqueColor: true,
                          ),
                        ],
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
