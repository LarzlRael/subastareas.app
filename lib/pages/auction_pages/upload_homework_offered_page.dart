part of '../pages.dart';

class UploadHomeworkOfferedPage extends StatefulWidget {
  final HomeworkArguments homeworkArguments;
  const UploadHomeworkOfferedPage({Key? key, required this.homeworkArguments})
      : super(key: key);

  @override
  State<UploadHomeworkOfferedPage> createState() =>
      _UploadHomeworkOfferedPageState();
}

class _UploadHomeworkOfferedPageState extends State<UploadHomeworkOfferedPage> {
  late HomeworksProvider oneHomeworkProvider;

  bool _loading = false;
  late OffersServices offersServices;
  late GlobalKey<FormBuilderState> formKey;
  @override
  void initState() {
    super.initState();
    oneHomeworkProvider = Provider.of<HomeworksProvider>(context, listen: false)
      ..getOneHomework(widget.homeworkArguments.idHomework);
    offersServices = OffersServices();
    formKey = GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(appBar: AppBar()),
      body: Consumer<HomeworksProvider>(
        builder: (_, oneHomeworkProviderC, child) {
          final homework = oneHomeworkProviderC.state.selectedHomework;

          final getIdOfferAccepted = oneHomeworkProviderC
              .state.selectedHomework!.offers
              .where((element) =>
                  element.status == "pending_to_resolve" ||
                  element.status == "pending_to_accept")
              .first
              .id;
          return SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: oneHomeworkProviderC.state.isLoadingSelected
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          /* mainAxisAlignment: MainAxisAlignment.center, */
                          children: [
                            ShowProfileImage(
                              profileImage:
                                  homework!.homework.user.profileImageUrl,
                              userName: homework.homework.user.username,
                              radius: 90,
                            ),
                            SimpleText(
                              text: homework.homework.title.toCapitalized(),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              bottom: 15,
                              top: 15,
                              textAlign: TextAlign.center,
                            ),
                            Timer(
                              endTime: homework.homework.resolutionTime,
                            ),
                            SimpleText(
                              top: 10,
                              text: homework.homework.offeredAmount.toString(),
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              bottom: 5,
                            ),
                            homework.homework.status != "pending_to_accept"
                                ? FormBuilder(
                                    /* initialValue: {
                                  'title': homework.title,
                                  'offered_amount': homework.offeredAmount.toString(),
                                  /* 'category': homework.category, */
                                  'resolutionTime': homework.resolutionTime,
                                }, */
                                    // TOOD notification after upload the file with the homework resolved
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const CustomFileField(
                                          name: 'file',
                                          isRequired: true,
                                        ),
                                        _loading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : FillButton(
                                                label: "Subir tarea resuelta",
                                                textColor: Colors.white,
                                                /* backgroundColor: Colors.green, */
                                                borderRadius: 30,
                                                onPressed: () {
                                                  uploadHomework(
                                                    getIdOfferAccepted,
                                                  );
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
                            tradeStatus(homework.homework.status, null),
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> uploadHomework(
    int getIdOfferAccepted,
  ) async {
    setState(() {
      _loading = true;
    });
    final idHomework = oneHomeworkProvider.state.selectedHomework!.homework.id;
    final validationSuccess = formKey.currentState!.validate();

    if (!validationSuccess) {
      setState(() {
        _loading = false;
      });
      return;
    }

    formKey.currentState!.save();

    offersServices
        .uploadHomeworkResolvedFile(
            getIdOfferAccepted, formKey.currentState!.value['file'][0].path)
        .then((value) {
      setState(() {
        _loading = false;
      });

      if (value) {
        context.pop();
        GlobalSnackBar.show(
          context,
          "Tarea resuelta subida correctamente",
          backgroundColor: Colors.green,
        );
        /* Refresh list */
        oneHomeworkProvider.getOneHomework(idHomework);
      } else {
        GlobalSnackBar.show(
          context,
          "Error al subir la tarea resuelta",
          backgroundColor: Colors.red,
        );
      }
    });
  }
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
  return const SizedBox();
}
