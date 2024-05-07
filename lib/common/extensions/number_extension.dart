extension DoubleHelper on double {
  double toFixed(int num) {
    return double.parse(toStringAsFixed(num));
  }
}