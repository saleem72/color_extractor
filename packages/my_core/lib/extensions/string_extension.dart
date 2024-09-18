//

extension StringSpecific on String {
  String onlyDigits() {
    final aStr = replaceAll(RegExp(r'[^0-9.]'), '');
    return aStr.trim();
  }

  String onlyCurrency() {
    final aStr = replaceAll(RegExp(r'[0-9.,]'), '');
    return aStr.trim();
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
