bool validateStatus(int? state) {
  const status = [200, 201, 202, 203, 204];
  return status.contains(state);
}

bool validateArray(List<dynamic> dataArray ) {
  return (dataArray.isNotEmpty ? true : false);
}