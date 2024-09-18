//

isValidNumber(double a, double b, String c) {
  if (a.isNaN || 0 > a || a > b) {
    throw Exception("$a for $c is not between 0 and $b");
  }
}
