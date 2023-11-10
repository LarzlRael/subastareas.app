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
  final TradeUserModel tradeUserModel;
  const VerifyHomeworkResolved({Key? key, required this.tradeUserModel})
      : super(key: key);

  @override
  State<VerifyHomeworkResolved> createState() => _VerifyHomeworkResolvedState();
}

class _VerifyHomeworkResolvedState extends State<VerifyHomeworkResolved> {
  bool loading = false;
  late TradeServices tradeServices;
  @override
  void initState() {
    super.initState();
    tradeServices = TradeServices();
  }

  void acceptHomework() {
    showAlertDialog(
        context, 'Se procedera a aceptar esta tarea, ¿Estas seguro?', () {
      setState(() {
        loading = true;
      });
      tradeServices
          .acceptOrDeclineTrade(widget.tradeUserModel.offerId, true)
          .then((value) {
        setState(() {
          loading = false;
        });
        if (value) {
          GlobalSnackBar.show(context, "Tarea aceptada y confirmada",
              backgroundColor: Colors.green);
          context.pop();
          /* Use bloc for this */
        } else {
          GlobalSnackBar.show(context, "Hubo un error",
              backgroundColor: Colors.red);
        }
      });
    });
  }

  void rejectHomework(GlobalKey<FormBuilderState> formKey) {
    final validationSuccess = formKey.currentState!.validate();
    if (!validationSuccess) {
      return;
    }
    showAlertDialog(
      context,
      '¿Estás seguro de rechazar esta tarea?',
      () {
        setState(() {
          loading = true;
        });
        tradeServices
            .acceptOrDeclineTrade(widget.tradeUserModel.offerId, false,
                reasonRejected:
                    formKey.currentState!.fields['commentTaskRejected']!.value)
            .then((value) {
          if (value) {
            setState(() {
              loading = true;
            });
            GlobalSnackBar.show(
              context,
              'Tarea rechazada',
              backgroundColor: Colors.red,
            );
            context.push(
              '/my_homeworks_page',
              extra: 1,
            );
            return;
          }

          GlobalSnackBar.show(
            context,
            'Hubo un error',
            backgroundColor: Colors.red,
          );
        });
      },
      content: const Text(
          "No olvides enviar un mensaje al usuario para que corrija la tarea"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tradeUserModel = widget.tradeUserModel;
    final formKey = GlobalKey<FormBuilderState>();

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
                        onPressed: () {
                          context.push(
                            '/show_homework_uploaded',
                            extra: tradeUserModel.solvedHomeworkUrl,
                          );
                        },
                      )
                    : const SizedBox(),
                tradeUserModel.solvedHomeworkUrl != null
                    ? Column(
                        children: [
                          tradeUserModel.status == 'accepted'
                              ? const Column(
                                  children: [
                                    SimpleText(
                                      text:
                                          'Esta tarea ya fue resuelta y aceptada, puedes ver ahora',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      bottom: 10,
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              child: const Text('Ver tarea resuelta'),
                              /* backgroundColor: Colors.green, */
                              /* borderRadius: 30, */
                              /* textColor: Colors.white, */
                              onPressed: () async {
                                context.push(
                                  '/show_homework_uploaded',
                                  extra: ShowHomeworkParams(
                                    title: tradeUserModel.title,
                                    fileType: tradeUserModel.solvedFileType,
                                    fileUrl: tradeUserModel.solvedHomeworkUrl!,
                                  ),
                                );
                              },
                            ),
                          ),
                          tradeUserModel.status != 'accepted'
                              ? FormBuilder(
                                  key: formKey,
                                  child: const Column(
                                    children: [
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
                          const SimpleText(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /*   Expanded(
                                child: FillButton(
                                  borderRadius: 5,
                                  label: "Rechazar",
                                  ghostButton: true,
                                  onPressed: () {
                                    rejectHomework(formKey.currentState!
                                        .fields['commentTaskRejected']!.value
                                        .toString());
                                  },
                                ),
                              ), */
                              IconButton(
                                onPressed: () {
                                  rejectHomework(formKey);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 70,
                                ),
                              ),
                              const SizedBox(width: 16),
                              /* Expanded(
                                child: FillButton(
                                  borderRadius: 5,
                                  label: "Aceptar",
                                  onPressed: acceptHomework,
                                ),
                              ) */
                              IconButton(
                                onPressed: acceptHomework,
                                icon: const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 70,
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
                              context.push(
                                  '/public_profile_page/${tradeUserModel.id}');
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
                tradeUserModel.status != 'accepted'
                    ? const Text(
                        "En caso de que la tarea no sea aceptada, enviale un mensaje al usuario para que la corrija*",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
