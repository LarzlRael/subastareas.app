part of 'utils.dart';

Duration getDateDiff(DateTime dt1) {
  /*  */
  DateTime dt2 = DateTime.now();
  Duration diff = dt1.difference(dt2);
  return diff;
}

String getDateDiffString(DateTime dt1) {
  DateTime dt2 = DateTime.now();
  Duration diff = dt1.difference(dt2);

  if (diff.isNegative) {
    return "Tiempo transcurrido";
  }

  if (diff.inDays > 0) {
    int days = diff.inDays;
    String dayString = days == 1 ? 'día' : 'días';
    int hours = diff.inHours % 24;
    String hourString = hours == 1 ? 'hora' : 'horas';
    return "$days $dayString y $hours $hourString restante${days == 1 && hours == 1 ? '' : 's'}";
  } else {
    int hours = diff.inHours;
    String hourString = hours == 1 ? 'hora' : 'horas';
    int minutes = diff.inMinutes % 60;
    String minuteString = minutes == 1 ? 'minuto' : 'minutos';
    return "$hours $hourString y $minutes $minuteString restante${hours == 1 && minutes == 1 ? '' : 's'}";
  }
}
