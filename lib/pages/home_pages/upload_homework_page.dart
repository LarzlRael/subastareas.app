part of '../pages.dart';

/* class UploadHomework extends StatefulWidget {
  const UploadHomework({Key? key}) : super(key: key);

  @override
  _UploadHomeworkState createState() => _UploadHomeworkState();
}

class _UploadHomeworkState extends State<UploadHomework> {
  final _formKey = GlobalKey<FormBuilderState>();

  final format = DateFormat("dd-MM-yyyy hh:mm");
  final category = [
    'matematica',
    'programacion',
    'lenguaje',
    'fisica',
    'quimica',
    'algebra',
    'trigonometria',
    'geometria',
  ];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir nueva tarea'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: SingleChfinal format = DateFormat("dd-MM-yyyy hh:mm");ildScrollView(
            child: Column(
              children: <Widget>[
                FormBuilderFilePicker(
                  /* allowedExtensions: const ['jpeg', 'jpg', 'heic', 'pdf'], */
                  name: 'files',
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(labelText: 'Attachments'),
                  maxFiles: 1,
                  allowMultiple: false,
                  previewImages: true,
                  onChanged: (val) => debugPrint(val.toString()),
                  selector: Row(
                    children: const <Widget>[
                      Icon(Icons.file_upload),
                      Text('Subir imagen o pdf'),
                    ],
                  ),
                  onFileLoading: (val) {
                    debugPrint(val.toString());
                  },
                  /* customFileViewerBuilder:
                      _useCustomFileViewer ? customFileViewerBuilder : null, */
                ),
                FormBuilderTextField(
                  name: 'title',
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'Titulo de la tarea',
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
                FormBuilderTextField(
                  name: 'description',
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'Descripcion',
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
                FormBuilderTextField(
                  name: 'offered_amount',
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'Precio de oferta',
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
                FormBuilderDropdown(
                  name: "category",
                  decoration: const InputDecoration(labelText: "Categoria"),
                  /* initialValue: category[0], */
                  hint: const Text('Categoria'),
                  validator: FormBuilderValidators.required(),
                  items: category
                      .map((category) => DropdownMenuItem(
                          value: category, child: Text("$category")))
                      .toList(),
                ),
                FormBuilderDateTimePicker(
                  format: format,
                  name: 'resolutionTime',
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(
                    labelText: 'tiempo de resolucion',
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Nueva tarea  '),
                      onPressed: () async {
                        _formKey.currentState!.save();
                        File file =
                            File(_formKey.currentState!.value['files'][0].path);
                        final res = await Request.sendRequestWithFile(
                          file,
                          'homework/create',
                          'POST',
                          {
                            'title': _formKey.currentState!.value['title'],
                            'description':
                                _formKey.currentState!.value['description'],
                            'offered_amount':
                                _formKey.currentState!.value['offered_amount'],
                            'category':
                                _formKey.currentState!.value['category'],
                            'resolutionTime': DateTime.now().toString(),
                          },
                          await authService.getCurrentToken(),
                        );
                        print(res);
                      },
                    ),
                    /* const Spacer(), */
                    /* ElevatedButton(
                      child: Text(_useCustomFileViewer
                          ? 'Use Default File Viewer'
                          : 'Use Custom File Viewer'),
                      onPressed: () {
                        setState(
                            () => _useCustomFileViewer = !_useCustomFileViewer);
                      },
                    ), */
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customFileViewerBuilder(
    List<PlatformFile>? files,
    FormFieldSetter<List<PlatformFile>> setter,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final file = files![index];
        return ListTile(
          title: Text(file.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              files.removeAt(index);
              setter.call([...files]);
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.blueAccent,
      ),
      itemCount: files!.length,
    );
  }
}
 */

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
              UploadHomeworkOnlyText(),
              UploadHomeworkWithFile(),
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
  UploadHomeworkOnlyText({
    Key? key,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
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

  UploadHomeworkWithFile({
    Key? key,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
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
