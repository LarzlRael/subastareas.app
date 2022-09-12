part of '../widgets.dart';

class CustomFormbuilderTextArea extends StatelessWidget {
  final String name;
  final IconData icon;
  final String title;
  final bool passwordField;
  final TextInputType keyboardType;
  const CustomFormbuilderTextArea({
    Key? key,
    required this.name,
    required this.icon,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.passwordField = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          bottom: 20,
        ),
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FormBuilderTextField(
              keyboardType: keyboardType,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
              name: name,
              validator: FormBuilderValidators.required(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
