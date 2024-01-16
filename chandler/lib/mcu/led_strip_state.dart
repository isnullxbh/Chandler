enum LedStripState {
  disabled,
  coolWhite,
  moderateWhite,
  warmWhite;

  static LedStripState? fromInt(int value) {
    switch (value) {
      case 0:
        return LedStripState.disabled;

      case 1:
        return LedStripState.coolWhite;

      case 2:
        return LedStripState.moderateWhite;

      case 3:
        return LedStripState.warmWhite;

      default:
        return null;
    }
  }
}
