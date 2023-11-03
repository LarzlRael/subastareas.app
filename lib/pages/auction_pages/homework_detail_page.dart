part of '../pages.dart';

class HomeworkdDetailPage extends StatefulWidget {
  /* final HomeworkArguments args; */
  final int idHomework;
  const HomeworkdDetailPage({
    Key? key,
    required this.idHomework,
  }) : super(key: key);
  @override
  State<HomeworkdDetailPage> createState() => _HomeworkdDetailPageState();
}

class _HomeworkdDetailPageState extends State<HomeworkdDetailPage> {
  late AuthServices auth;
  late HomeworksProvider oneHomeworkProvider;

  @override
  void initState() {
    super.initState();
    auth = Provider.of<AuthServices>(context, listen: false);
    oneHomeworkProvider = context.read<HomeworksProvider>();
    oneHomeworkProvider.getOneHomework(widget.idHomework);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ), */
      body: Consumer<HomeworksProvider>(
          builder: (_, oneHomeworkProviderC, child) {
        final selectedHomework = oneHomeworkProvider.state.selectedHomework;
        final isBearer = selectedHomework?.homework != null &&
            selectedHomework!.homework.user.id == auth.user.id;
        return oneHomeworkProviderC.state.isLoadingSelected
            ? const Center(child: CircularProgressIndicator())
            : !selectedHomework!.homework.visible
                ? const Center(
                    child: NoInformation(
                      icon: Icons.visibility_off,
                      message: "Esta tarea no está disponible",
                      showButton: false,
                      iconButton: Icons.add,
                    ),
                  )
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                          elevation: 5,
                          leading: IconButton(
                            onPressed: context.pop,
                            icon: const Icon(
                              Icons.chevron_left,
                              size: 25,
                            ),
                          ),
                          actions: <Widget>[
                            isBearer
                                ? Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          selectedHomework.offers.isEmpty
                                              ? context.push(
                                                  '/upload_homework_with_file',
                                                  extra:
                                                      selectedHomework.homework,
                                                  /* PageTransition(
                                        type: PageTransitionType
                                            .leftToRightWithFade,
                                        child: UploadHomeworkOnlyText(),
                                        settings: snapshot.data!.homework,
                                      ), */
                                                )
                                              : GlobalSnackBar.show(
                                                  context,
                                                  "No puedes editar tu tarea porque ya tiene ofertas",
                                                  backgroundColor: Colors.red,
                                                );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 25,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          final status =
                                              selectedHomework.homework.status;
                                          if (status != 'traded' ||
                                              status != 'pending_to_resolve' ||
                                              status != 'pending_to_resolve') {
                                            showConfirmDialog(
                                              context,
                                              'Retirar tarea',
                                              '¿Estás seguro de eliminar esta tarea?',
                                              () => oneHomeworkProvider
                                                  .deleteHomework(
                                                      selectedHomework
                                                          .homework.id)
                                                  .then((value) {
                                                if (value) {
                                                  context.pop();
                                                  GlobalSnackBar.show(context,
                                                      "Tarea eliminada Exitosamente",
                                                      backgroundColor:
                                                          Colors.blue);
                                                } else {
                                                  GlobalSnackBar.show(context,
                                                      "En este momento no puedes eliminar esta tarea",
                                                      backgroundColor:
                                                          Colors.red);
                                                }
                                              }),
                                            );
                                          } else {
                                            GlobalSnackBar.show(context,
                                                "En este momento no puedes eliminar esta tarea",
                                                backgroundColor: Colors.red);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
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
                                selectedHomework.homework.category,
                              )}.jpg',
                              fit: BoxFit.cover,
                              /* width: 280.0, */
                            ),
                            centerTitle: true,
                            title: SimpleText(
                              text:
                                  'Tarea de ${selectedHomework.homework.category} ',
                              lightThemeColor: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                /* mainAxisAlignment: MainAxisAlignment.spaceBetween, */
                                children: [
                                  _cardAuction(
                                    selectedHomework,
                                    auth.isLogged,
                                    false,
                                    isBearer,
                                  ),
                                  selectedHomework.homework.status ==
                                          'accepted_to_offer'
                                      ? _buttonMakeOffer(
                                          selectedHomework, auth.isLogged)
                                      : const SizedBox(),
                                  selectedHomework.homework.status ==
                                          'accepted_to_offer'
                                      ? CommentsByHomework(
                                          comments: selectedHomework.comments,
                                          isLogged: auth.isLogged,
                                          idHomework:
                                              selectedHomework.homework.id,
                                          auth: auth,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
      }),
    );
  }

  Widget _cardAuction(OneHomeworkModel oneHomeworkModel, bool isLogged,
      bool loading, bool isBearer) {
    final _formKey = GlobalKey<FormBuilderState>();
    final supervisorServices = SuperviseServices();
    return Container(
      /* padding: const EdgeInsets.all(10), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: oneHomeworkModel.homework.title.toCapitalized(),
            fontWeight: FontWeight.w500,
            bottom: 10,
            fontSize: 22,
          ),
          isBearer
              ? homeworkStatus(
                  oneHomeworkModel.homework.status,
                  isBearer,
                  oneHomeworkModel.homework.observation,
                )
              : const SizedBox(),
          Container(
            /* color: Colors.yellow, */
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              /* crossAxisAlignment: CrossAxisAlignment.center, */
              children: [
                _infoContainer(
                    'Creador',
                    SizedBox(
                      child: Row(
                        children: [
                          ShowProfileImage(
                            profileImage:
                                oneHomeworkModel.homework.user.profileImageUrl,
                            userName: oneHomeworkModel.homework.user.username,
                            radius: 25,
                          ),
                          const SizedBox(width: 7),
                          SimpleText(
                            text: oneHomeworkModel.homework.user.username
                                .toCapitalized(),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    )),
                /* _infoContainer(
                  'Acaba en ',
                  Timer(
                    endTime: oneHomeworkModel.homework.resolutionTime,
                  ),
                  /* CustomTimer(
                      resolutionTime: oneHomeworkModel.homework.resolutionTime), */
                ), */
              ],
            ),
          ),
          description(oneHomeworkModel.homework.description),
          oneHomeworkModel.homework.fileUrl != null
              ? TextButton(
                  child: const Text('Ver Tarea '),
                  onPressed: () {
                    context.push(
                      '/show_homework',
                      extra: oneHomeworkModel.homework,
                    );
                  },
                )
              : const SizedBox(),
          oneHomeworkModel.offers.isNotEmpty
              ? CircleAvatarGroup(
                  oneHomeworkModel: oneHomeworkModel,
                )
              : const SizedBox(),
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
                      child: const Column(
                        children: [
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
                            onPressed: () {
                              _formKey.currentState!.save();

                              supervisorServices
                                  .superviseHomework(
                                _formKey.currentState!.value['observation'],
                                'rejected',
                                oneHomeworkModel.homework.id,
                              )
                                  .then((value) {
                                if (value) {
                                  context.pop();
                                  GlobalSnackBar.show(
                                      context, "Tarea Calificada",
                                      backgroundColor: Colors.green);
                                } else {
                                  GlobalSnackBar.show(context, "Hubo un error",
                                      backgroundColor: Colors.red);
                                }
                              });
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

                              supervisorServices
                                  .superviseHomework(
                                _formKey.currentState!.value['observation'],
                                'accepted_to_offer',
                                oneHomeworkModel.homework.id,
                              )
                                  .then((value) {
                                setState(() {
                                  loading = false;
                                });
                                if (value) {
                                  context.pop();
                                  GlobalSnackBar.show(
                                      context, "Tarea aceptada y confirmada",
                                      backgroundColor: Colors.green);
                                } else {
                                  GlobalSnackBar.show(context, "Hubo un error",
                                      backgroundColor: Colors.red);
                                }
                              });
                            },
                          ),
                        )
                      ],
                    )
                  ],
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
    bool isBearer = false;
    if (isLogged) {
      isBearer = oneHomeworkModel.homework.user.id == auth.user.id;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.purple,
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
                navigatorProtected(
                  context,
                  isLogged,
                  '/auction_with_offerPage',
                  oneHomeworkModel,
                );
              } else {
                navigatorProtected(
                  context,
                  isLogged,
                  '/makeOffer',
                  oneHomeworkModel,
                );
              }
            },
            child: isBearer ? const Text('Ver ofertas') : const Text('Ofertar'),
          ),
        ],
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

  Widget homeworkStatus(
    String status,
    bool isBearer,
    String? observation,
  ) {
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
      case "pending_to_resolve":
        return statusMessage(
            'El profesor subira esta tarea pronto', Icons.pending_actions,
            color: Colors.orange);
      case "traded":
        return Column(
          children: [
            statusMessage(
              'Esta tarea ya fue resuelta',
              Icons.check_circle,
              color: Colors.green,
            ),
          ],
        );
    }
    return Container();
  }

  /* Future<void> deleteAndRefresh(int idHomework) async {
    oneHomeworkProvider.deleteHomework(
      idHomework,
    );

    /* Navigator.pushNamed(context, 'bottomNavigation'); */
    context.pop();

    await auth.refreshUser();
    GlobalSnackBar.show(context, "Tarea eliminada Exitosamente",
        backgroundColor: Colors.blue);
  } */
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
