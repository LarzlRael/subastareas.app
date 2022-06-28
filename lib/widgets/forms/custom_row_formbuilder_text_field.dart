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
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            SimpleText(
              text: widget.placeholder,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: FormBuilderTextField(
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
            ),
          ],
        ));
  }
}
