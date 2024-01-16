import 'dart:typed_data';

import 'package:chandler/mcu/control_type.dart';
import 'package:chandler/mcu/led_strip_state.dart';
import 'package:chandler/mcu/light_sensor_dependency.dart';
import 'package:chandler/mcu/light_sensor_state.dart';

class McuState {
  ControlType controlType = ControlType.local;
  bool relay1Enabled = false;
  LightSensorDependency relay1Lsd = LightSensorDependency.disabled;
  bool relay2Enabled = false;
  LightSensorDependency relay2Lsd = LightSensorDependency.disabled;
  LedStripState ledStripState = LedStripState.disabled;
  LightSensorDependency ledStripLsd = LightSensorDependency.disabled;
  LightSensorState lightSensorState = LightSensorState.low;

  static McuState createFrom(Uint8List data) {
    var state = McuState();
    state.controlType = ControlType.fromInt(data.elementAt(0))!;
    state.relay1Enabled = data.elementAt(1) == 1;
    state.relay1Lsd = LightSensorDependency.fromInt(data.elementAt(3))!;
    state.relay2Enabled = data.elementAt(2) == 1;
    state.relay2Lsd = LightSensorDependency.fromInt(data.elementAt(4))!;
    state.ledStripState = LedStripState.fromInt(data.elementAt(5))!;
    state.ledStripLsd = LightSensorDependency.fromInt(data.elementAt(6))!;
    state.lightSensorState = data.elementAt(7) == 0 ? LightSensorState.low : LightSensorState.high;
    return state;
  }
}
