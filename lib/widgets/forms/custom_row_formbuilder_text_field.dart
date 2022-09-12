part of '../widgets.dart';

class CustomRowFormbuilderTextField extends StatelessWidget {
  final String name;
  final String placeholder;
  final TextInputType keyboardType;
  final IconData suffixIcon;
  final String? Function(String?)? validator;
  const CustomRowFormbuilderTextField({
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
      inputField: FormBuilderTextField(
        keyboardType: keyboardType,
        name: name,
        // multiple validation
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          /* labelText: widget.placeholder, */

          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          suffixIcon: Icon(suffixIcon),
        ),
      ),
    );
  }
}
