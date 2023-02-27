class OpacityCalculator {
  static double getOpacityForBackground({
    required double appBarSize,
    required double maxAppBarMaxHeight,
    required double minAppBarMaxHeight,
  }) {
    double minusValueToCalculateOpacity = maxAppBarMaxHeight - appBarSize;
    double opacity = minusValueToCalculateOpacity / minAppBarMaxHeight;
    // opacity += 0.2; //Customize this value as per the animation in the UI
    if (opacity > 0.6) {
      opacity = 1;
    }
    else if (opacity < 0.4) {
      opacity = 0;
    }
    return opacity;
  }
}