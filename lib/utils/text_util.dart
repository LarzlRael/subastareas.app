import 'package:simple_moment/simple_moment.dart';

String convertName(String name) {
  String newName = name.trim();
  if (name.split(' ').length > 1) {
    newName = name[0][0] + ' ' + name[0][1];
  } else {
    newName = newName.trim().substring(0, 2);
  }
  return newName.toUpperCase();
}

String removeDiacritics(String str) {
  var withDia =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var withoutDia =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  for (int i = 0; i < withDia.length; i++) {
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }

  return str.toLowerCase();
}

String capitalizeFirstLetter(String string) {
  return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
}

String convertTime(DateTime date, {String format = 'dd/MM/yyyy HH:mm'}) {
  Moment rawDate = Moment.fromDate(date);
  return rawDate.format(format);
}
/* String literalDate(DateTime date) {
  Moment rawDate = Moment.fromDate(date);
  return rawDate.format("dd-MM-yyyy HH:mm");
} */
