part of '../pages.dart';

class MakeOfferPage extends StatefulWidget {
  final OneHomeworkModel oneHomework;
  const MakeOfferPage({Key? key, required this.oneHomework}) : super(key: key);

  @override
  State<MakeOfferPage> createState() => _MakeOfferPageState();
}

class _MakeOfferPageState extends State<MakeOfferPage> {
  TextEditingController textController = TextEditingController();
  bool editing = false;
  late HomeworksProvider blocHomework;
  late SocketService socketService;
  late Offer? getUserOffer;
  late bool getFindUserOffer = false;
  late AuthProvider auth;
  @override
  void initState() {
    super.initState();
    socketService = context.read<SocketService>();
    auth = context.read<AuthProvider>();
    blocHomework = context.read<HomeworksProvider>();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final oneHomework = widget.oneHomework;

    final verifyUserOffered =
        oneHomework.offers.map((item) => item.user.id).contains(auth.user.id);

    if (verifyUserOffered) {
      getUserOffer =
          oneHomework.offers.firstWhere((item) => item.user.id == auth.user.id);
      getFindUserOffer = true;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ShowProfileImage(
                  profileImage: oneHomework.homework.user.profileImageUrl,
                  userName: oneHomework.homework.user.username,
                  radius: 50,
                ),
                SimpleText(
                  top: 25,
                  bottom: 25,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  lightThemeColor: Colors.black87,
                  text: oneHomework.homework.user.username,
                ),
                SimpleText(
                  top: 5,
                  bottom: 25,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  lightThemeColor: Colors.black87,
                  text: oneHomework.homework.title.toCapitalized(),
                  /* color: Colors.grey, */
                ),
                oneHomework.homework.description != null
                    ? DescriptionText(
                        desc: oneHomework.homework.description!,
                        textAlign: TextAlign.center,
                        dropDown: false,
                      )
                    : Container(),
                const SimpleText(
                  text: "Tiempo restante",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  bottom: 5,
                ),
                Timer(endTime: oneHomework.homework.resolutionTime),
                verifyUserOffered
                    ? SimpleText(
                        text:
                            'Tu oferta es de ${getUserOffer!.priceOffer} puntos',
                        top: 15,
                        bottom: 15,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      )
                    : const SizedBox(
                        height: 10,
                      ),
                const SimpleText(
                  text: 'Precio',
                  top: 15,
                  bottom: 15,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
                SizedBox(
                  /* color: Colors.grey[200], */
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: SimpleText(
                    text: '${oneHomework.homework.offeredAmount}',
                    textAlign: TextAlign.center,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: verifyUserOffered
                      ? verifyUserOffered && getUserOffer!.edited
                          ? Container()
                          : ButtonWithIcon(
                              verticalPadding: 15,
                              onPressed: () {
                                showOfferDialog(
                                  oneHomework.homework,
                                  auth.user,
                                  verifyUserOffered,
                                  amount: getUserOffer!.priceOffer,
                                  idOffer: getUserOffer!.id,
                                );
                              },
                              label: 'Editar oferta',
                              icon: Icons.edit,
                              /* marginVertical: 10, */
                            )
                      : ButtonWithIcon(
                          verticalPadding: 15,
                          onPressed: () {
                            showOfferDialog(
                              oneHomework.homework,
                              auth.user,
                              verifyUserOffered,
                              amount: oneHomework.homework.offeredAmount,
                            );
                          },
                          label: verifyUserOffered
                              ? 'Editar oferta'
                              : 'Hacer oferta',
                          icon: Icons.send,
                          /* marginVertical: 10, */
                        ),
                ),
                verifyUserOffered && getUserOffer!.edited
                    ? const SimpleText(
                        text: 'Ya has editado tu oferta',
                        top: 15,
                        bottom: 15,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      )
                    : const SizedBox(
                        height: 10,
                      ),
                verifyUserOffered
                    ? FillButton(
                        marginVertical: 15,
                        onPressed: () {
                          showAlertDialog(
                              context, '¿Estás seguro de retirar tu oferta?',
                              () {
                            blocHomework
                                .deleteOffer(
                                    oneHomework.homework.id, getUserOffer!.id)
                                .then(
                              (value) {
                                socketService.emit('deleteOffer', {
                                  'room': oneHomework.homework.id,
                                  'offer': value,
                                });
                                context.pop();
                                GlobalSnackBar.show(
                                  context,
                                  'Oferta retirada correctamente',
                                  backgroundColor: Colors.blue,
                                );
                              },
                            );
                          });
                        },
                        label: 'Retirar oferta',
                        ghostButton: true,
                        backgroundColor: Colors.red[700]!.withOpacity(0.8),
                        borderRadius: 100,

                        /* backgroundColorButton: Colors.red,
                        icon: Icons.delete, */

                        /* marginVertical: 10, */
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showOfferDialog(
    Homework homework,
    UserModel userModel,
    bool verify, {
    int amount = 0,
    int? idOffer,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;
        final formKey = GlobalKey<FormState>();
        int ammountOffered = 0;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              contentPadding: const EdgeInsets.only(
                top: 10.0,
              ),
              title: SimpleText(
                text: !verify ? "Hacer oferta" : "Editar oferta",
                fontSize: 24.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              content: SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ingrese cantidad ",
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SimpleText(
                                text:
                                    "Puntos requeridos: ${homework.offeredAmount}",
                                fontSize: 12,
                                bottom: 5,
                              ),
                              /* SimpleText(
                                text:
                                    "Puntos disponibles: ${userModel.wallet.balanceTotal}",
                                fontSize: 12,
                              ), */
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            initialValue: verify ? amount.toString() : '',
                            decoration: const InputDecoration(
                              labelText: 'Ingrese su oferta',
                            ),
                            readOnly: isLoading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'La oferta es requerida';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                ammountOffered = int.parse(value!),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(
                          onPressed: !isLoading
                              ? () {
                                  if (!formKey.currentState!.validate()) return;
                                  formKey.currentState!.save();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  blocHomework
                                      .makeOrEditOffer(
                                    homework.id,
                                    ammountOffered,
                                    idOffer: idOffer,
                                  )
                                      .then((newOffer) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    socketService.emit(
                                        idOffer == null
                                            ? 'makeOfferToServer'
                                            : 'editOffer',
                                        {
                                          'room': homework.id,
                                          'offer': newOffer,
                                        });

                                    GlobalSnackBar.show(
                                        context,
                                        idOffer == null
                                            ? 'Oferta realizada correctamente'
                                            : 'Oferta editada correctamente',
                                        backgroundColor: idOffer == null
                                            ? Colors.green
                                            : Colors.blue);
                                    context.push('/my_offers_page');
                                  });
                                }
                              : null,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  !verify ? "Ofertar" : "Editar oferta",
                                ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const SimpleText(text: 'Nota: '),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(7.0),
                        child: SimpleText(
                          text:
                              'Solo puedes editar tu oferta una vez, si quieres cambiarla, debes eliminar esta oferta y hacer una nueva oferta',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
