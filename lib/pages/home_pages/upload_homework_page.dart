part of '../pages.dart';

class UploadHomeworkPage extends StatefulWidget {
  const UploadHomeworkPage({Key? key}) : super(key: key);

  @override
  State<UploadHomeworkPage> createState() => _UploadHomeworkPageState();
}

class _UploadHomeworkPageState extends State<UploadHomeworkPage> {
  /* final format = DateFormat("dd-MM-yyyy hh:mm"); */

  final sizeTabIcon = 35.0;
  final colorTab = Colors.grey;
  @override
  Widget build(BuildContext context) {
    /* final authServices = Provider.of<AuthServices>(context, listen: true); */
    final theme = Provider.of<ThemeChanger>(context, listen: true);
    return Scaffold(
      appBar: AppBarTitle(
        title: 'SUBIR NUEVA TAREA',
        fontSize: 20,
        appBar: AppBar(),
      ),
      body: DefaultTabController(
        length: tabsOptions().length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor:
                theme.getDarkTheme ? Colors.transparent : Colors.grey[100],
            toolbarHeight: 20,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              /* indicatorColor: Colors.blue, */
              padding: const EdgeInsets.only(bottom: 20),
              tabs: tabsOptions(),
            ),
          ),
          body: const TabBarView(
            children: [
              UploadHomeworkWithFile(homework: null),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadHomeworkWithFile extends StatefulWidget {
  final Homework? homework;
  const UploadHomeworkWithFile({
    Key? key,
    this.homework,
  }) : super(key: key);

  @override
  State<UploadHomeworkWithFile> createState() => _UploadHomeworkWithFileState();
}

class _UploadHomeworkWithFileState extends State<UploadHomeworkWithFile> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _isWithFile = false;
  late bool isNewHomework;
  Homework homework = Homework(
    id: 0,
    title: '',
    description: '',
    offeredAmount: 0,
    fileUrl: null,
    fileType: '',
    resolutionTime: DateTime.now(),
    category: '',
    observation: '',
    status: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    user: CommentUser(
      id: 0,
      profileImageUrl: '',
      username: '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final homeworkData = ModalRoute.of(context)?.settings.arguments;
    final homeworksService = HomeworkServices();
    final authService = Provider.of<AuthServices>(context, listen: false);
    if (homeworkData != null) {
      homework = homeworkData as Homework;
    }
    isNewHomework = homework.id == 0;
    return Scaffold(
      appBar: isNewHomework
          ? null
          : AppBarWithBackIcon(
              appBar: AppBar(),
            ),
      body: SafeArea(
        child: uploadHomework(context, authService, homeworksService),
      ),
    );
  }

  Widget uploadHomework(
    BuildContext context,
    AuthServices authService,
    HomeworkServices homeworksService,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: FormBuilder(
          initialValue: {
            'title': homework.title,
            'offered_amount': homework.offeredAmount.toString(),
            /* 'category': homework.category, */
            'resolutionTime': homework.resolutionTime,
          },
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SimpleText(
                    text:
                        'Tu saldo actual es de: ${authService.user.wallet.balanceTotal}',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    bottom: 10,
                  ),
                  GenericListTile(
                    icon: Icons.file_open,
                    title: 'Subir tarea con archivo',
                    initialValue: _isWithFile,
                    onChanged: (value) {
                      setState(() {
                        _isWithFile = value;
                      });
                    },
                  ),
                  _isWithFile
                      ? const CustomFileField(
                          name: 'file',
                          /* title: 'Subir archivo',
                            icon: Icons.file_upload, */
                        )
                      : const SizedBox(),
                  /* const CustomFileField(
                      name: 'file',
                    ), */
                  const CustomFormBuilderTextArea(
                    name: 'title',
                    title: 'Escribe tu pregunta',
                    icon: Icons.person,
                  ),
                  CustomRowFormBuilderTextField(
                    name: 'offered_amount',
                    placeholder: 'Presupuesto ',
                    keyboardType: TextInputType.number,
                    suffixIcon: FontAwesomeIcons.coins,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.max(
                            authService.user.wallet.balanceTotal),
                        FormBuilderValidators.min(1),
                      ],
                    ),
                  ),
                  CustomDatePicker(
                    name: 'resolutionTime',
                    suffixIcon: FontAwesomeIcons.calendarDays,
                    placeholder: 'Tiempo de resolución : ',
                    keyboardType: TextInputType.datetime,
                    validator: FormBuilderValidators.compose([
                      (selectedDateTime) {
                        if (selectedDateTime == null) {
                          return 'Selecciona una fecha';
                        }
                        if (selectedDateTime
                            .difference(DateTime.now())
                            .isNegative) {
                          return 'Selected DateTime is in the future';
                        }
                        return null;
                      }
                    ]),
                  ),
                  const CustomFormBuilderFetchDropdown(
                    formFieldName: 'category',
                    placeholder: 'Seleccione una categoria',
                    title: 'Categoria :',
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  !_isLoading
                      ? FillButton(
                          label: isNewHomework ? "Subir Tarea" : "Editar Tarea",
                          borderRadius: 20,
                          textColor: Colors.white,
                          onPressed: () async {
                            final validationSuccess =
                                _formKey.currentState!.validate();

                            if (validationSuccess) {
                              _formKey.currentState!.save();
                              debugPrint(
                                  _formKey.currentState!.value.toString());

                              if (_isWithFile) {
                                final Map<String, String> data = {
                                  'title':
                                      _formKey.currentState!.value['title'],
                                  'offered_amount': _formKey
                                      .currentState!.value['offered_amount'],
                                  'category':
                                      _formKey.currentState!.value['category'],
                                  'resolutionTime': _formKey
                                      .currentState!.value['resolutionTime']
                                      .toString(),
                                };
                                _formKey.currentState!.save();
                                /* print(_formKey.currentState!.value); */
                                final uploadHomework = await homeworksService
                                    .uploadHomeworkWithFile(
                                  data,
                                  File(_formKey
                                      .currentState!.value['file'][0].path),
                                );

                                _successUploaded(uploadHomework, authService);
                              } else {
                                final Map<String, String> data = {
                                  'title':
                                      _formKey.currentState!.value['title'],
                                  'offered_amount': _formKey
                                      .currentState!.value['offered_amount'],
                                  'category':
                                      _formKey.currentState!.value['category'],
                                  'resolutionTime': _formKey
                                      .currentState!.value['resolutionTime']
                                      .toString(),
                                };
                                _formKey.currentState!.save();
                                showFilterBottomMenuSheetxD(
                                  context,
                                );
                                setState(() {
                                  _isLoading = true;
                                });
                                final uploadHomework = await homeworksService
                                    .uploadHomeworkOnlyText(
                                  data,
                                  homework.id,
                                );

                                _successUploaded(uploadHomework, authService);
                              }
                            }
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _successUploaded(
    bool uploadHomework,
    AuthServices authService,
  ) async {
    if (uploadHomework) {
      Navigator.pushNamed(context, 'my_homeworks_page');
      _formKey.currentState!.reset();
      setState(() {
        _isLoading = false;
      });
      await authService.renewToken();
      GlobalSnackBar.show(context, 'Tarea subida correctamente',
          backgroundColor: Colors.green);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      setState(() {
        _isLoading = false;
      });
      GlobalSnackBar.show(context, 'Error al subir tarea',
          backgroundColor: Colors.red);
    }
  }
}

showFilterBottomMenuSheetxD(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const SafeArea(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    },
  );
}
