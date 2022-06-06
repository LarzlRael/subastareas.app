part of '../pages.dart';

class UploadHomework extends StatefulWidget {
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
                        final res = await Services.sendRequestWithFile(
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
