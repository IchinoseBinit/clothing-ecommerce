extension Ex on dynamic {
  double toPrecision(int n) {
    double number = double.tryParse(toString()) ?? 0.00;
    return number == 0.00 ? 0.00 : double.parse(number.toStringAsFixed(n));
  }
}

parseDoubleToFixedPrecision(dynamic value, {int decimalPoint = 2}) {
  if (value == null ||
      double.tryParse(value.toString()) == null ||
      value == 0 ||
      value == 0.0) {
    return 0.0;
  } else {
    return (double.tryParse(
      value.toString(),
    )).toPrecision(decimalPoint);
  }
}
