part of '../widgets.dart';

class CustomFileField extends StatelessWidget {
  final String name;

  const CustomFileField({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
      /* type: FileType.custom, */
      typeSelectors: const [
        TypeSelector(
          type: FileType.custom,
          selector: Row(
            children: [
              Icon(Icons.upload_file),
              SizedBox(width: 3),
              SimpleText(
                text: 'Escoger archivo',
                fontSize: 16,
              ),
            ],
          ),
        )
      ],
      allowMultiple: false,
      allowedExtensions: const ['jpg', 'png', 'pdf'],
      name: name,
      /* validator: FormBuilderValidators.required(), */
      decoration: const InputDecoration(
        labelText: "Subir archivo",
        hintText: "Subir archivo",
        //
        border: InputBorder.none,
      ),
      maxFiles: 1,
      /* previewImages: true, */
      onChanged: (val) => print(val),
      /*  selector: Row(
        children: const [
          Icon(FontAwesomeIcons.file),
          SimpleText(
            text: 'Escoger archivo',
            fontSize: 16,
          ),
        ],
      ), */
      onFileLoading: (val) {
        print(val);
      },
    );
  }
}
