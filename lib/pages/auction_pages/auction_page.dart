part of '../pages.dart';

class AuctionPage extends StatefulWidget {
  final HomeworkArguments args;
  const AuctionPage({Key? key, required this.args}) : super(key: key);
  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  late AuthServices auth;
  final _oneHomeworkBloc = OneHomeworkBloc();

  @override
  void initState() {
    /* getOneHomeWork(); */
    _oneHomeworkBloc.getOneHomework(widget.args.idHomework);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthServices>(context, listen: false);
    bool isBearer = false;
    if (auth.isLogged) {
      isBearer = widget.args.idUser == auth.user.id;
    }
    return Scaffold(
      /* appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ), */
      body: StreamBuilder(
        stream: _oneHomeworkBloc.oneHomeworkStream,
        builder:
            (BuildContext context, AsyncSnapshot<OneHomeworkModel> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                    elevation: 5,
                    centerTitle: true,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    actions: <Widget>[
                      isBearer
                          ? Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    snapshot.data!.offers.isEmpty
                                        ? Navigator.pushNamed(
                                            context,
                                            'upload_homework_with_file',
                                            arguments: snapshot.data!.homework,
                                            /* PageTransition(
                                          type: PageTransitionType
                                              .leftToRightWithFade,
                                          child: UploadHomeworkOnlyText(),
                                          settings: snapshot.data!.homework,
                                        ), */
                                          )
                                        : GlobalSnackBar.show(context,
                                            "No puedes editar tu tarea porque ya tiene ofertas",
                                            backgroundColor: Colors.red);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    snapshot.data!.offers.isEmpty
                                        ? showConfirmDialog(
                                            context,
                                            'Eliminar comentario',
                                            '¿Estás seguro de eliminar este comentario?',
                                            () => _oneHomeworkBloc
                                                .commentService
                                                .deleteComment(
                                              snapshot.data!.homework.id,
                                            ),
                                          )
                                        : GlobalSnackBar.show(context,
                                            "No puedes eliminar esta tarea porque ya tiene ofertas",
                                            backgroundColor: Colors.red);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                    floating: true,
                    pinned: true,
                    snap: false,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        'assets/category/${removeDiacritics(
                          snapshot.data!.homework.category,
                        )}.jpg',
                        fit: BoxFit.cover,
                        /* width: 280.0, */
                      ),
                      centerTitle: true,
                      title: SimpleText(
                        text: 'Tarea de ${snapshot.data!.homework.category} ',
                        lightThemeColor: Colors.white,
                        fontSize: 16,
                      ),
                    )),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  _cardAuction(
                                    snapshot.data!,
                                    auth.isLogged,
                                    false,
                                    isBearer,
                                  )
                                ],
                              ),
                            ],
                          ),
                          /* _buttonMakeOffer(), */
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _cardAuction(OneHomeworkModel oneHomeworkModel, bool isLogged,
      bool loading, bool isBearer) {
    final _formKey = GlobalKey<FormBuilderState>();
    final supervisorServices = SuperviseServices();
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: oneHomeworkModel.homework.title.toCapitalized(),
            fontWeight: FontWeight.w500,
            bottom: 15,
            fontSize: 22,
          ),
          isBearer
              ? homeworkStatus(
                  oneHomeworkModel.homework.status,
                  isBearer,
                  oneHomeworkModel.homework.observation,
                )
              : Container(
                  /*   child: Text(
                    oneHomeworkModel.homework.status,
                  ), */
                  ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoContainer(
                  'Creador',
                  Row(
                    children: [
                      showProfileImage(
                          oneHomeworkModel.homework.user.profileImageUrl,
                          oneHomeworkModel.homework.user.username),
                      const SizedBox(
                        width: 7,
                      ),
                      SimpleText(
                        text: oneHomeworkModel.homework.user.username
                            .toCapitalized(),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ],
                  )),
              _infoContainer(
                'Acaba en ',
                Timer(
                  endTime: oneHomeworkModel.homework.resolutionTime,
                ),
              ),
            ],
          ),
          description(oneHomeworkModel.homework.description),
          oneHomeworkModel.homework.status == 'accepted_to_offer'
              ? _buttonMakeOffer(oneHomeworkModel, isLogged)
              : Container(),
          oneHomeworkModel.homework.fileUrl != null
              ? TextButton(
                  child: const Text('Ver Tarea '),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'showHomework',
                      arguments: oneHomeworkModel.homework,
                    );
                  },
                )
              : Container(),
          CircleAvatarGroup(
            oneHomeworkModel: oneHomeworkModel,
          ),
          oneHomeworkModel.homework.status == 'pending_to_accept' &&
                  isAdmin(auth.user.userRols)
              ? Column(
                  children: [
                    oneHomeworkModel.homework.observation != null
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            child: SimpleText(
                              text: oneHomeworkModel.homework.observation!,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Container(),
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: const [
                          CustomFormBuilderTextArea(
                            name: 'observation',
                            icon: FontAwesomeIcons.notesMedical,
                            title: 'Observación',
                          ),
                        ],
                      ),
                    ),
                    /* _formKey.currentState!.save();
                        await supervisorServices.superviseHomework(
                          _formKey.currentState!.value['observation'],
                          'rejected',
                          oneHomeworkModel.homework.id,
                        ); */
                    Row(
                      children: [
                        Expanded(
                          child: FillButton(
                            borderRadius: 5,
                            label: "Rechazar",
                            ghostButton: true,
                            onPressed: () async {
                              _formKey.currentState!.save();
                              final accepted =
                                  await supervisorServices.superviseHomework(
                                _formKey.currentState!.value['observation'],
                                'rejected',
                                oneHomeworkModel.homework.id,
                              );
                              if (accepted) {
                                Navigator.pop(context);
                                GlobalSnackBar.show(context, "Tarea Calificada",
                                    backgroundColor: Colors.green);
                              } else {
                                GlobalSnackBar.show(context, "Hubo un error",
                                    backgroundColor: Colors.red);
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
                              _formKey.currentState!.save();
                              setState(() {
                                loading = true;
                              });
                              final accepted =
                                  await supervisorServices.superviseHomework(
                                _formKey.currentState!.value['observation'],
                                'accepted_to_offer',
                                oneHomeworkModel.homework.id,
                              );
                              setState(() {
                                loading = false;
                              });
                              if (accepted) {
                                Navigator.pop(context);
                                GlobalSnackBar.show(
                                    context, "Tarea aceptada y confirmada",
                                    backgroundColor: Colors.green);
                              } else {
                                GlobalSnackBar.show(context, "Hubo un error",
                                    backgroundColor: Colors.red);
                              }
                            },
                          ),
                        )
                      ],
                    )
                  ],
                )
              : Container(),
          oneHomeworkModel.homework.status == 'accepted_to_offer'
              ? CommentsWidget(
                  comments: oneHomeworkModel.comments,
                  isLogged: isLogged,
                  idHomework: oneHomeworkModel.homework.id,
                )
              : Container(),
        ],
      ),
    );
  }

  _infoContainer(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: title,
          fontSize: 16,
          lightThemeColor: Colors.grey,
          bottom: 10,
        ),
        content,
      ],
    );
  }

  Widget _buttonMakeOffer(OneHomeworkModel oneHomeworkModel, bool isLogged) {
    /* Change this for the condition */
    final size = MediaQuery.of(context).size;
    bool isBearer = false;
    if (isLogged) {
      isBearer = oneHomeworkModel.homework.user.id == auth.user.id;
    }
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: size.width * 1,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          /* crossAxisAlignment: CrossAxisAlignment.stretch, */
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SimpleText(
                  text: 'Ofertar',
                  fontSize: 15,
                  lightThemeColor: Colors.white,
                ),
                SimpleText(
                  text: '${oneHomeworkModel.homework.offeredAmount} bs',
                  fontSize: 20,
                  lightThemeColor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                /* Navigator.pushNamed(context, 'makeOffer'); */
                if (isBearer) {
                  navigatorProtected(context, isLogged, 'auctionWithOfferPage',
                      oneHomeworkModel);
                } else {
                  navigatorProtected(
                      context, isLogged, 'makeOffer', oneHomeworkModel);
                }
              },
              child:
                  isBearer ? const Text('Ver ofertas') : const Text('Ofertar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget description(String? desc) {
    if (desc == null || desc.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SimpleText(
          text: 'Descripción',
          top: 20,
          bottom: 10,
          lightThemeColor: Colors.black,
          fontSize: 18,
        ),
        DescriptionText(
          dropDown: false,
          desc: desc,
        ),
      ],
    );
  }

  Widget homeworkStatus(String status, bool isBearer, String? observation) {
    switch (status) {
      case "accepted_to_offer":
        return statusMessage('Aceptada', Icons.check_circle);
      case "rejected":
        return Column(
          children: [
            statusMessage('Rechazada', Icons.cancel, color: Colors.red),
            observation != null
                ? SimpleText(
                    text: 'Observación: $observation',
                    lightThemeColor: Colors.red,
                    fontSize: 16,
                    bottom: 10,
                  )
                : Container(),
          ],
        );
      case "pending_to_accept":
        return statusMessage('En proceso de aprobación', Icons.lock_clock,
            color: Colors.orange);
    }
    return Container();
  }

  Widget statusMessage(String message, IconData icon,
      {Color color = Colors.green}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 5),
          SimpleText(
            text: message,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            lightThemeColor: color,
          ),
        ],
      ),
    );
  }
}
