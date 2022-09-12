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
      body: Container(
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
                print(getIdOfferAccepted);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showProfileImage(
                      homework.user.profileImageUrl,
                      homework.user.username,
                      radius: 90,
                    ),
                    SimpleText(
                      text: homework.title,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      bottom: 20,
                      top: 20,
                    ),
                    SimpleText(
                      bottom: 20,
                      top: 20,
                      text: homework.resolutionTime.toString(),
                    ),
                    SimpleText(
                      text: homework.offeredAmount.toString(),
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                    FormBuilder(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomFileField(
                            name: 'file',
                          ),
                          _loading
                              ? const Center(child: CircularProgressIndicator())
                              : FillButton(
                                  text: "Subir tarea resuelta",
                                  textColor: Colors.white,
                                  /* backgroundColor: Colors.green, */
                                  borderRadius: 30,
                                  onPressed: () async {
                                    setState(() {
                                      _loading = true;
                                    });
                                    final validationSuccess =
                                        _formKey.currentState!.validate();

                                    if (validationSuccess) {
                                      _formKey.currentState!.save();

                                      final response = await offersServices
                                          .uploadHomeworkResolvedFile(
                                              File(
                                                _formKey.currentState!
                                                    .value['file'][0].path,
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
                                          backgroundColor: Colors.green,
                                        );
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
                          /* RaisedButton(
                        onPressed: () async {
                          await authService.logout();
                        },
                        child: Text('Cerrar sesion'),
                      ), */
                        ],
                      ),
                    ),
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
    );
  }
}
