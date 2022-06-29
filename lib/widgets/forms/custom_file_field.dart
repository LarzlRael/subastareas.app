part of '../widgets.dart';

class CustomFileField extends StatelessWidget {
  final String name;

  const CustomFileField({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormBuilderFilePicker(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: const ['jpg', 'png', 'pdf'],
        name: name,
        decoration: InputDecoration(labelText: "Attachments"),
        maxFiles: null,
        previewImages: true,
        onChanged: (val) => print(val),
        selector: Row(
          children: <Widget>[
            Icon(FontAwesomeIcons.file),
            Text('Subir archivo'),
          ],
        ),
        onFileLoading: (val) {
          print(val);
        },
      ),
    );
  }
}
