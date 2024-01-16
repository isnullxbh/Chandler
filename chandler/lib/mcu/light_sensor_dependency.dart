enum LightSensorDependency {
  disabled,
  direct,
  inverse;

  static LightSensorDependency? fromInt(int value) {
    switch (value) {
      case 0:
        return LightSensorDependency.disabled;

      case 1:
        return LightSensorDependency.direct;

      case 2:
        return LightSensorDependency.inverse;

      default:
        return null;
    }
  }
}
