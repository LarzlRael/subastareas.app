part of '../widgets.dart';

class CustomFormBuilderTextField extends HookWidget {
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
  Widget build(BuildContext context) {
    final obscureText = useState(true);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: FormBuilderTextField(
          keyboardType: keyboardType,
          obscureText: passwordField && obscureText.value,
          name: name,
          validator: FormBuilderValidators.required(),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: placeholder,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            suffixIcon: passwordField
                ? IconButton(
                    icon: obscureText.value
                        ? const Icon(Icons.password, size: 20)
                        : const Icon(Ionicons.eye, size: 20),
                    onPressed: () => obscureText.value = !obscureText.value,
                  )
                : null,
            prefixIcon: Icon(icon, size: 20),
          ),
        ),
      ),
    );
  }
}
