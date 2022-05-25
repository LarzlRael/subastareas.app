part of 'text.dart';

class TextOnTap extends StatelessWidget {
  final SimpleText text;
  final VoidCallback onTap;
  const TextOnTap({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: text,
    );
  }
}
