part of 'widgets.dart';

class TimerCounter extends StatefulWidget {
  final int endTime;
  final TextStyle? testStyle;
  const TimerCounter({
    Key? key,
    required this.endTime,
    this.testStyle,
  }) : super(key: key);
  @override
  State<TimerCounter> createState() => _TimerCounterState();
}

class _TimerCounterState extends State<TimerCounter> {
  late CountdownTimerController controller;

  /* int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30; */

  @override
  void initState() {
    super.initState();
    controller =
        CountdownTimerController(endTime: widget.endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      controller: controller,
      onEnd: onEnd,
      endTime: widget.endTime,
      endWidget: const Text(
        '00:00:00',
        /* style: widget.testStyle, */
      ),
      textStyle: widget.testStyle,
    );
  }
}
