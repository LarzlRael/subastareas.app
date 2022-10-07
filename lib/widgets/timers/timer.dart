part of '../widgets.dart';

class Timer extends StatelessWidget {
  final DateTime endTime;
  final TextStyle? textStyle;

  const Timer({
    Key? key,
    this.textStyle,
    required this.endTime,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getDateDiff(endTime).inMilliseconds > 0
        ? TimerCounter(
            endTime: isEnd(),
            testStyle: textStyle,
          )
        : const SimpleText(
            text: "Expirado",
          );
  }

  int isEnd() {
    return DateTime.now().millisecondsSinceEpoch +
        getDateDiff(endTime).inMilliseconds;
  }
}
