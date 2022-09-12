part of '../widgets.dart';

class InputContainer extends StatelessWidget {
  final String name;
  final String placeholder;
  final Widget inputField;
  const InputContainer(
      {Key? key,
      required this.name,
      required this.placeholder,
      required this.inputField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: placeholder,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: inputField,
            ),
          ),
        ],
      ),
    );
  }
}
