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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const SimpleText(
          text: 'Subir nueva tarea',
          color: Colors.black,
          fontSize: 20,
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 5,
            backgroundColor: Colors.white,
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
              UploadHomeworkWithFile(authService: authServices),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadHomeworkOnlyText extends StatefulWidget {
  final AuthServices authService;
  UploadHomeworkOnlyText({
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
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
                          'Tu saldo actual es de: ${widget.authService.user.wallet.balance}',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      top: 10,
                      bottom: 10,
                    ),
                    CustomFormbuilderTextArea(
                      name: 'title',
                      title: 'Escribe tu pregunta',
                      icon: Icons.person,
                    ),
                    CustomRowFormbuilderTextField(
                      name: 'offered_amount',
                      placeholder: 'Presupuesto ',
                      keyboardType: TextInputType.number,
                      suffixIcon: FontAwesomeIcons.coins,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.max(
                            widget.authService.user.wallet.balance),
                        FormBuilderValidators.min(1),
                      ]),
                    ),
                    /* CustomRowFormbuilderTextField(
                      name: 'username',
                      icon: FontAwesomeIcons.at,
                      placeholder: 'Plazo : ',
                    ), */
                    /* text: 'Tiempo de resolucion : ',
                            name: 'resolutionTime', */
                    CustomDatePicker(
                      name: 'resolutionTime',
                      suffixIcon: FontAwesomeIcons.calendarDays,
                      placeholder: 'Tiempo de resolucion : ',
                      keyboardType: TextInputType.datetime,
                    ),
                    CustomFormbuilderFetchDropdown(
                      formFieldName: 'category',
                      placeholder: 'Seleccione una categoria',
                      title: 'Categoria :',
                    ),
                    /* RaisedButton(
                        onPressed: () async {
                          await authService.logout();
                        },
                        child: Text('Cerrar sesion'),
                      ), */
                  ],
                ),
                Column(
                  children: [
                    LoginButton(
                      buttonChild: Text(
                        homework.id == 0 ? "Subir Tarea" : 'Editar Tarea',
                      ),
                      textColor: Colors.white,
                      showIcon: false,
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                        });
                        final validationSuccess =
                            _formKey.currentState!.validate();
                        print(_formKey.currentState!.value['']);
                        print(_formKey.currentState!.value['offered_amount']);
                        print(_formKey.currentState!.value['category']);
                        print(_formKey.currentState!.value['resolutionTime']);
                        if (validationSuccess) {
                          _formKey.currentState!.save();
                          /* print(_formKey.currentState!.value); */
                          final data = {
                            'title': _formKey.currentState!.value['title'],
                            'offered_amount':
                                _formKey.currentState!.value['offered_amount'],
                            'category':
                                _formKey.currentState!.value['category'],
                            'resolutionTime': _formKey
                                .currentState!.value['resolutionTime']
                                .toString(),
                          };

                          if (await homeworksService.uploadHomeworOnlyText(
                            data,
                            homework.id,
                          )) {
                            Navigator.pushNamed(context, 'my_homeworks_page');
                            _formKey.currentState!.reset();
                            setState(() {
                              _loading = true;
                            });
                            GlobalSnackBar.show(
                                context, 'Tarea subida correctamente',
                                backgroundColor: Colors.green);
                          }
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UploadHomeworkWithFile extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final AuthServices authService;
  UploadHomeworkWithFile({
    Key? key,
    required this.authService,
  }) : super(key: key);

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
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
                          'Tu saldo actual es de: ${authService.user.wallet.balance}',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      top: 10,
                      bottom: 10,
                    ),
                    CustomFileField(
                      name: 'file',
                    ),
                    CustomFormbuilderTextArea(
                      name: 'title',
                      title: 'Escribe tu pregunta',
                      icon: Icons.person,
                    ),
                    CustomRowFormbuilderTextField(
                        name: 'offered_amount',
                        placeholder: 'Presupuesto ',
                        keyboardType: TextInputType.number,
                        suffixIcon: FontAwesomeIcons.coins),
                    /* CustomRowFormbuilderTextField(
                      name: 'username',
                      icon: FontAwesomeIcons.at,
                      placeholder: 'Plazo : ',
                    ), */
                    /* text: 'Tiempo de resolucion : ',
                            name: 'resolutionTime', */
                    CustomDatePicker(
                      name: 'resolutionTime',
                      suffixIcon: FontAwesomeIcons.calendarDays,
                      placeholder: 'Tiempo de resolucion : ',
                      keyboardType: TextInputType.datetime,
                    ),
                    CustomFormbuilderFetchDropdown(
                      formFieldName: 'category',
                      placeholder: 'Seleccione una categoria',
                      title: 'Categoria :',
                    ),
                    /* RaisedButton(
                        onPressed: () async {
                          await authService.logout();
                        },
                        child: Text('Cerrar sesion'),
                      ), */
                  ],
                ),
                Column(
                  children: [
                    LoginButton(
                      buttonChild: Text(
                          homework.id == 0 ? "Subir Tarea" : 'Editar Tarea'),
                      textColor: Colors.white,
                      showIcon: false,
                      onPressed: () async {
                        final validationSuccess =
                            _formKey.currentState!.validate();
                        print(_formKey.currentState!.value['title']);
                        print(_formKey.currentState!.value['offered_amount']);
                        print(_formKey.currentState!.value['category']);
                        print(_formKey.currentState!.value['resolutionTime']);
                        if (validationSuccess) {
                          _formKey.currentState!.save();
                          /* print(_formKey.currentState!.value); */
                          final Map<String, String> data = {
                            'title': _formKey.currentState!.value['title'],
                            'offered_amount':
                                _formKey.currentState!.value['offered_amount'],
                            'category':
                                _formKey.currentState!.value['category'],
                            'resolutionTime': _formKey
                                .currentState!.value['resolutionTime']
                                .toString(),
                          };

                          await homeworksService.uploadHomeworkWithFile(
                              data,
                              File(_formKey
                                  .currentState!.value['file'][0].path));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
