part of '../widgets.dart';
/*

class CustomRowFormbuilderTextField extends StatefulWidget {
  final String name;
  final IconData icon;
  final String placeholder;
  final bool passwordField;
  final TextInputType keyboardType;
  final IconData suffixIcon;
  const CustomRowFormbuilderTextField({
    Key? key,
    required this.name,
    required this.icon,
    required this.placeholder,
    required this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.passwordField = false,
  }) : super(key: key);

  @override
  State<CustomRowFormbuilderTextField> createState() => _input_containerState();
}

class _input_containerState extends State<CustomRowFormbuilderTextField> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      name: widget.name,
      placeholder: widget.placeholder,
      icon: widget.icon,
      inputField: FormBuilderTextField(
        keyboardType: widget.keyboardType,
        name: widget.name,
        validator: FormBuilderValidators.required(),
        decoration: const InputDecoration(
          border: InputBorder.none,
          /* labelText: widget.placeholder, */

          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          suffixIcon: Icon(FontAwesomeIcons.coins),
        ),
      ),
    );
  }
}
 */

class CustomDatePicker extends StatelessWidget {
  final String name;

  final String placeholder;
  final TextInputType keyboardType;
  final IconData suffixIcon;
  final String? Function(DateTime?)? validator;
  const CustomDatePicker({
    Key? key,
    required this.name,
    required this.placeholder,
    required this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      name: name,
      placeholder: placeholder,
      inputField: FormBuilderDateTimePicker(
        /* format: format, */
        name: 'resolutionTime',
        // time validation
        validator: validator,

        decoration: const InputDecoration(
          suffixIcon: Icon(FontAwesomeIcons.clock),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
