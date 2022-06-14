part of '../widgets.dart';

class CustomRowFormbuilderTextField extends StatefulWidget {
  final String name;
  final IconData icon;
  final String placeholder;
  final bool passwordField;
  final TextInputType keyboardType;
  const CustomRowFormbuilderTextField({
    Key? key,
    required this.name,
    required this.icon,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.passwordField = false,
  }) : super(key: key);

  @override
  State<CustomRowFormbuilderTextField> createState() =>
      _CustomRowFormbuilderTextFieldState();
}

class _CustomRowFormbuilderTextFieldState
    extends State<CustomRowFormbuilderTextField> {
  bool _obscureText = true;
  /* bool showPassword = false; */
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          child: Row(
            children: [
              SimpleText(
                text: widget.placeholder,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              Expanded(
                child: Card(
                  elevation: 15,
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
                      /* labelText: widget.placeholder, */
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      /* suffixIcon: widget.passwordField
                          ? IconButton(
                              icon: _obscureText
                                  ? const Icon(Icons.password)
                                  : const Icon(Ionicons.eye),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )
                          : null,
                      prefixIcon: Icon(widget.icon), */
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
