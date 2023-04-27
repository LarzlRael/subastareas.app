part of '../widgets.dart';

class CustomFormBuilderTextField extends StatefulWidget {
  final String name;
  final IconData icon;
  final String placeholder;
  final bool passwordField;
  final TextInputType keyboardType;
  const CustomFormBuilderTextField({
    Key? key,
    required this.name,
    required this.icon,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.passwordField = false,
  }) : super(key: key);

  @override
  State<CustomFormBuilderTextField> createState() =>
      _CustomFormBuilderTextFieldState();
}

class _CustomFormBuilderTextFieldState
    extends State<CustomFormBuilderTextField> {
  bool _obscureText = true;
  /* bool showPassword = false; */
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: FormBuilderTextField(
          keyboardType: widget.keyboardType,
          obscureText: widget.passwordField && _obscureText,
          name: widget.name,
          validator: FormBuilderValidators.required(),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: widget.placeholder,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            suffixIcon: widget.passwordField
                ? IconButton(
                    icon: _obscureText
                        ? const Icon(Icons.password, size: 20)
                        : const Icon(Ionicons.eye, size: 20),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            prefixIcon: Icon(widget.icon, size: 20),
          ),
        ),
      ),
    );
  }
}
