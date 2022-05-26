String convertName(String name) {
  String newName = name.trim();
  if (name.split(' ').length > 1) {
    newName = name[0][0] + ' ' + name[0][1];
  } else {
    newName = newName.trim().substring(0, 2);
  }
  return newName.toUpperCase();
}
