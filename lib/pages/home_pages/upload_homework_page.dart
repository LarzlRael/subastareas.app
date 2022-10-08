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
    final authServices = Provider.of<AuthServices>(context, listen: true);
    final theme = Provider.of<ThemeChanger>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            theme.getDarkTheme ? Colors.transparent : Colors.grey[100],
        title: const SimpleText(
          text: 'SUBIR NUEVA TAREA',
          lightThemeColor: Colors.black87,
          darkThemeColor: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 4,
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
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.keyboard,
                      size: sizeTabIcon, color: colorTab),
                ),
                Tab(
                  icon: Icon(Icons.image, size: sizeTabIcon, color: colorTab),
                ),
                Tab(
                  icon: Icon(Icons.mic, size: sizeTabIcon, color: colorTab),
                ),
                Tab(
                  icon: Icon(Icons.video_label_rounded,
                      size: sizeTabIcon, color: colorTab),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UploadHomeworkOnlyText(authService: authServices),
              UploadHomeworkWithFile(homework: null),
              const Icon(Icons.directions_transit),
              const Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadHomeworkOnlyText extends StatefulWidget {
  final AuthServices authService;
  const UploadHomeworkOnlyText({
    Key? key,
    required this.authService,
  }) : super(key: key);

  @override
  State<UploadHomeworkOnlyText> createState() => _UploadHomeworkOnlyTextState();
}

class _UploadHomeworkOnlyTextState extends State<UploadHomeworkOnlyText> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;

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
    if (homeworkData != null) {
      homework = homeworkData as Homework;
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            child: FormBuilder(
              initialValue: {
                'title': homework.title,
                'offered_amount': homework.offeredAmount.toString(),
                'resolutionTime': homework.resolutionTime,
                /* 'category': homework.category, */
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
                            'Tu saldo actual es de: ${widget.authService.user.wallet.balanceTotal}',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        bottom: 10,
                      ),
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
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.max(
                              widget.authService.user.wallet.balanceTotal),
                          FormBuilderValidators.min(1),
                        ]),
                      ),

                      /* text: 'Tiempo de resolucion : ',
                              name: 'resolutionTime', */
                      CustomDatePicker(
                        name: 'resolutionTime',
                        suffixIcon: FontAwesomeIcons.calendarDays,
                        placeholder: 'Tiempo de resolución : ',
                        keyboardType: TextInputType.datetime,
                        validator: FormBuilderValidators.compose([
                          (selectedDateTime) {
                            debugPrint(selectedDateTime.toString());
                            if (selectedDateTime == null) {
                              return 'Selecciona una fecha';
                            }
                            if (!selectedDateTime
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
                  !_loading
                      ? FillButton(
                          label:
                              homework.id == 0 ? "Subir Tarea" : 'Editar Tarea',
                          borderRadius: 20,
                          textColor: Colors.white,
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            final validationSuccess =
                                _formKey.currentState!.validate();

                            if (validationSuccess) {
                              _formKey.currentState!.save();

                              final data = {
                                'title': _formKey.currentState!.value['title'],
                                'offered_amount': _formKey
                                    .currentState!.value['offered_amount'],
                                'category':
                                    _formKey.currentState!.value['category'],
                                'resolutionTime': _formKey
                                    .currentState!.value['resolutionTime']
                                    .toString(),
                              };
                              setState(() {
                                _loading = true;
                              });
                              final uploadHomework =
                                  await homeworksService.uploadHomeworkOnlyText(
                                data,
                                homework.id,
                              );
                              if (uploadHomework) {
                                Navigator.pushNamed(
                                    context, 'my_homeworks_page');
                                _formKey.currentState!.reset();
                                setState(() {
                                  _loading = false;
                                });
                                GlobalSnackBar.show(
                                    context, 'Tarea subida correctamente',
                                    backgroundColor: Colors.green);
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                                GlobalSnackBar.show(
                                    context, 'Error al subir tarea',
                                    backgroundColor: Colors.red);
                              }
                            }
                          },
                        )
                      : const Center(child: CircularProgressIndicator())
                ],
              ),
            ),
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
    return Scaffold(
      body: SingleChildScrollView(
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
                            label: homework.id == 0
                                ? "Subir Tarea"
                                : "Editar Tarea",
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
                                    'category': _formKey
                                        .currentState!.value['category'],
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
                                  _successUploaded(uploadHomework);
                                } else {
                                  final Map<String, String> data = {
                                    'title':
                                        _formKey.currentState!.value['title'],
                                    'offered_amount': _formKey
                                        .currentState!.value['offered_amount'],
                                    'category': _formKey
                                        .currentState!.value['category'],
                                    'resolutionTime': _formKey
                                        .currentState!.value['resolutionTime']
                                        .toString(),
                                  };
                                  _formKey.currentState!.save();
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final uploadHomework = await homeworksService
                                      .uploadHomeworkOnlyText(
                                    data,
                                    homework.id,
                                  );
                                  _successUploaded(uploadHomework);
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
      ),
    );
  }

  void _successUploaded(bool uploadHomework) {
    if (uploadHomework) {
      Navigator.pushNamed(context, 'my_homeworks_page');
      _formKey.currentState!.reset();
      setState(() {
        _isLoading = false;
      });
      GlobalSnackBar.show(context, 'Tarea subida correctamente',
          backgroundColor: Colors.green);
    } else {
      setState(() {
        _isLoading = false;
      });
      GlobalSnackBar.show(context, 'Error al subir tarea',
          backgroundColor: Colors.red);
    }
  }
}
