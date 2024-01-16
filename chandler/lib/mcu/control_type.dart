enum ControlType {
  local,
  remote;

  static ControlType? fromInt(int value) {
    switch (value) {
      case 0:
        return ControlType.local;
      case 1:
        return ControlType.remote;
      default:
        return null;
    }
  }
}
