part of '../pages.dart';

class UploadHomeworkOfferedPage extends StatefulWidget {
  const UploadHomeworkOfferedPage({Key? key}) : super(key: key);

  @override
  State<UploadHomeworkOfferedPage> createState() =>
      _UploadHomeworkOfferedPageState();
}

class _UploadHomeworkOfferedPageState extends State<UploadHomeworkOfferedPage> {
  final _oneHomeworkBloc = OneHomeworkBloc();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final offersServices = OffersServices();
    final homeworkArguments =
        ModalRoute.of(context)!.settings.arguments as HomeworkArguments;
    _oneHomeworkBloc.getOneHomework(homeworkArguments.idHomework);
    return Scaffold(
      appBar: AppBarWithBackIcon(appBar: AppBar()),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: _oneHomeworkBloc.oneHomeworkStream,
                builder: (BuildContext context,
                    AsyncSnapshot<OneHomeworkModel> snapshot) {
                  if (snapshot.hasData) {
                    final homework = snapshot.data!.homework;

                    //TODO cambiar esto en la base de datos
                    final getIdOfferAccepted = snapshot.data!.offers
                        .where((element) =>
                            element.status == "pending_to_resolve" ||
                            element.status == "pending_to_accept")
                        .first
                        .id;

                    return Column(
                      /* mainAxisAlignment: MainAxisAlignment.center, */
                      children: [
                        ShowProfileImage(
                          profileImage: homework.user.profileImageUrl,
                          userName: homework.user.username,
                          radius: 90,
                        ),
                        SimpleText(
                          text: homework.title.toCapitalized(),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          bottom: 15,
                          top: 15,
                          textAlign: TextAlign.center,
                        ),
                        Timer(
                          endTime: homework.resolutionTime,
                        ),
                        SimpleText(
                          top: 10,
                          text: homework.offeredAmount.toString(),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          bottom: 5,
                        ),
                        homework.status != "pending_to_accept"
                            ? FormBuilder(
                                /* initialValue: {
                            'title': homework.title,
                            'offered_amount': homework.offeredAmount.toString(),
                            /* 'category': homework.category, */
                            'resolutionTime': homework.resolutionTime,
                          }, */
                                // TOOD notification after upload the file with the homework resolved
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const CustomFileField(
                                      name: 'file',
                                    ),
                                    _loading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : FillButton(
                                            label: "Subir tarea resuelta",
                                            textColor: Colors.white,
                                            /* backgroundColor: Colors.green, */
                                            borderRadius: 30,
                                            onPressed: () async {
                                              setState(() {
                                                _loading = true;
                                              });
                                              final validationSuccess = _formKey
                                                  .currentState!
                                                  .validate();

                                              if (validationSuccess) {
                                                _formKey.currentState!.save();

                                                final response =
                                                    await offersServices
                                                        .uploadHomeworkResolvedFile(
                                                            File(
                                                              _formKey
                                                                  .currentState!
                                                                  .value['file']
                                                                      [0]
                                                                  .path,
                                                            ),
                                                            getIdOfferAccepted);
                                                setState(() {
                                                  _loading = false;
                                                });
                                                if (response) {
                                                  Navigator.pop(context);
                                                  GlobalSnackBar.show(
                                                    context,
                                                    "Tarea resuelta subida correctamente",
                                                    backgroundColor:
                                                        Colors.green,
                                                  );
                                                  /* Refresh list */
                                                  _oneHomeworkBloc
                                                      .getOneHomework(
                                                          homeworkArguments
                                                              .idHomework);
                                                } else {
                                                  setState(() {
                                                    _loading = false;
                                                  });
                                                  GlobalSnackBar.show(
                                                    context,
                                                    "Error al subir la tarea resuelta",
                                                    backgroundColor: Colors.red,
                                                  );
                                                }
                                              } else {
                                                setState(() {
                                                  _loading = false;
                                                });
                                              }
                                            },
                                          ),
                                  ],
                                ),
                              )
                            : const SimpleText(
                                top: 10,
                                text:
                                    "La tarea ya fue enviada para su revisión, espere por favor",
                                fontSize: 16,
                                textAlign: TextAlign.center,
                              ),
                        tradeStatus(homework.status, null),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tradeStatus(String status, String? rejectedReason) {
    switch (status) {
      case "reject":
        return statusMessage(
            'Tarea enviada y en espera de la revision', Icons.check_circle);
      case "rejected_offer_homework":
        return statusMessage('La tarea fue rechazada', Icons.warning,
            color: Colors.red);
      case "pending_to_accept":
        return const SizedBox();
    }
    return Container();
  }
}
