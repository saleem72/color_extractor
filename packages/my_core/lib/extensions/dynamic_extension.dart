//

double? maybeDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value);
  }
  return null;
}

int? maybeInt(dynamic value) {
  if (value is num) {
    return value.toInt();
  }
  if (value is String) {
    final integer = int.tryParse(value);

    if (integer == null) {
      return double.tryParse(value)?.toInt();
    }
    return integer;
  }

  return null;
}
