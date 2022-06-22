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
          child: SingleChildScrollView(
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
            backgroundColor: Colors.white,
            toolbarHeight: 20,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              indicatorColor: Colors.grey,
              padding: EdgeInsets.only(bottom: 20),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.filePdf,
                      size: 40, color: Colors.grey),
                ),
                Tab(
                  icon: Icon(Icons.image, size: 40, color: Colors.grey),
                ),
                Tab(
                  icon: Icon(Icons.mic, size: 40, color: Colors.grey),
                ),
                Tab(
                  icon: Icon(Icons.video_label_rounded,
                      size: 40, color: Colors.grey),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UploadHomeworkWithPDF(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadHomeworkWithPDF extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  UploadHomeworkWithPDF({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const CustomFormbuilderTextArea(
                name: 'title',
                title: 'Escribe tu pregunta',
                icon: Icons.person,
              ),
              const CustomRowFormbuilderTextField(
                name: 'username',
                icon: FontAwesomeIcons.at,
                placeholder: 'Presupuesto : ',
              ),
              const CustomRowFormbuilderTextField(
                name: 'username',
                icon: FontAwesomeIcons.at,
                placeholder: 'Plazo : ',
              ),
              CustomFormbuilderFetchDropdown(),
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
                text: "Subir Tarea",
                textColor: Colors.white,
                showIcon: false,
                onPressed: () async {
                  final validationSuccess = _formKey.currentState!.validate();
                  print(_formKey.currentState!.value['username']);
                  print(_formKey.currentState!.value['password']);
                  if (validationSuccess) {
                    _formKey.currentState!.save();
                    /* Navigator.pushReplacementNamed(
                              context, 'bottomNavigation'); */

                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
