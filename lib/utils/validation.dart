bool validateStatus(int? state) {
  const status = [200, 201, 202, 203, 204];
  return status.contains(state);
}

bool validateArray(List<dynamic> dataArray) {
  return (dataArray.isNotEmpty ? true : false);
}

bool validateEmail(String email) {
  return !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
