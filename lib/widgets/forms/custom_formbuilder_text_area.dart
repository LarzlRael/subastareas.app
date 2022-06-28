part of '../widgets.dart';

class CustomFormbuilderTextArea extends StatefulWidget {
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
  State<CustomFormbuilderTextArea> createState() =>
      _CustomFormbuilderTextAreaState();
}

class _CustomFormbuilderTextAreaState extends State<CustomFormbuilderTextArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: widget.title,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            bottom: 20,
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FormBuilderTextField(
                keyboardType: widget.keyboardType,
                maxLines: 2,
                name: widget.name,
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
      ),
    );
  }
}
