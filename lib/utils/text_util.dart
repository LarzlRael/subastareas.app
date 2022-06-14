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
