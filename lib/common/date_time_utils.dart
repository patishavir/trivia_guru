String getStrTimeStamp () {
  return DateTime.now().toString();
}

int getIntTimeStamp () {
  return DateTime.now().microsecondsSinceEpoch;
}