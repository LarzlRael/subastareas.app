part of 'text.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? darkThemeColor;
  final TextStyle? style;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final TextAlign? textAlign;
  final double? lineHeight;
  const SimpleText({
    Key? key,
    required this.text,
    this.fontWeight,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.fontSize,
    this.color,
    this.style,
    this.textAlign,
    this.lineHeight,
    this.darkThemeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    final themeDark = brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(
          top: top ?? 0,
          bottom: bottom ?? 0,
          left: left ?? 0,
          right: right ?? 0),
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        style: style ??
            TextStyle(
                height: lineHeight,
                fontWeight: fontWeight ?? FontWeight.normal,
                fontSize: fontSize ?? 14,
                /* color: color ?? Colors.black, */
                /*  color: color != null
                  ? isDarkMode
                      ? Colors.black
                      : Colors.white
                  : color, */
                /* color: isDarkMode
                  ? darkThemeColor ?? Colors.white
                  : color ?? Colors.black, */
                color: !themeDark
                    ? color ?? Colors.black
                    : darkThemeColor ?? Colors.white),
      ),
    );
  }
}
