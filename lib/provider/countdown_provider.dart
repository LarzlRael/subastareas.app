part of 'providers.dart';

class CountdownProvider extends ChangeNotifier {
  Duration duration = const Duration(seconds: 660928);
  bool isRunning = false;

  StreamSubscription<int>? _tickSubscription;

  CountdownProvider() {
    _startTimer(duration.inSeconds);
  }
  void startStopTimer() {
    if (!isRunning) {
      _startTimer(duration.inSeconds);
    } else {
      // Pausar el timer
      _tickSubscription?.pause();
    }

    isRunning = !isRunning;
    notifyListeners();
  }

  void _startTimer(int seconds) {
    _tickSubscription?.cancel();
    _tickSubscription = Stream<int>.periodic(
            const Duration(seconds: 1), (sec) => seconds - sec - 1)
        .take(seconds)
        .listen((timeLeftInSeconds) {
      duration = Duration(seconds: timeLeftInSeconds);
      notifyListeners();
    });
  }

  void setCountdownDuration(Duration newDuration) {
    duration = newDuration;
    _tickSubscription?.cancel();
    isRunning = false;
    notifyListeners();
  }

  String get timeLeftString {
    final minutes =
        ((duration.inSeconds / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds =
        (duration.inSeconds % 60).floor().toString().padLeft(2, '0');

    /* hours en 24 format */
    final hours = (duration.inHours % 24).floor().toString().padLeft(2, '0');
    // days in 24 format
    final days = (duration.inDays).floor().toString().padLeft(2, '0');

    return '$days:$hours:$minutes:$seconds';
  }
}
