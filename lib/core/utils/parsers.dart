/// Parses valid string to int else to null
int? intParseString(String? str) {
  if (str == null || str.trim().isEmpty) {
    return null;
  }
  return int.tryParse(str);
}

/// Parses valid string to double else to null
double? doubleParseString(String? str) {
  if (str == null || str.trim().isEmpty) {
    return null;
  }
  return double.tryParse(str);
}
