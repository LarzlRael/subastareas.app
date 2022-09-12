Duration getDateDiff(DateTime dt1) {
  /*  */
  DateTime dt2 = DateTime.now();
  Duration diff = dt1.difference(dt2);
  return diff;
}
