//

class RGBModel {
  final int red;
  final int green;
  final int blue;
  final double alpha;
  RGBModel({
    required this.red,
    required this.green,
    required this.blue,
    required this.alpha,
  });

  @override
  String toString() {
    return 'RGBModel(red: $red, green: $green, blue: $blue, alpha: $alpha)';
  }
}
